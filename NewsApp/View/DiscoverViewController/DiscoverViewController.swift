//
//  DiscoverViewController.swift
//  NewsApp
//
//  Created by Marta Korol on 09.08.2023.
//

import UIKit

final class DiscoverViewController: BaseNewsViewController {
    
    static let identifier = "DiscoverViewController"

    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var filterButton: UIButton!
    @IBOutlet weak private var tableView: UITableView!
    
    private var discoverViewModel: DiscoverViewModel {
        return (viewModel as? DiscoverViewModel) ?? DiscoverViewModel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DiscoverViewModel()
    }

    @IBAction func filterButtonPressed(_ sender: Any) {
        let filterVC = FilterViewController()
        navigationController?.pushViewController(filterVC, animated: true)
    }
    
    override func setupTableView() {
        super.setupTableView()
        view.backgroundColor = .systemBackground
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: NewsItemCell.identifier, bundle: nil),
                           forCellReuseIdentifier: NewsItemCell.identifier)
        tableView.register(UINib(nibName: LoadingCell.identifier, bundle: nil),
                           forCellReuseIdentifier: LoadingCell.identifier)

        tableView.refreshControl = refreshControl
    }

    override func reloadTable() {
        super.reloadTable()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }
    }

    @objc override func refreshData() {
        super.refreshData()
        discoverViewModel.loadData() { [weak self] in
            self?.reloadTable()
        }
    }
    
    private func endTyping() {
        filterButton.isHidden = false
        searchBar.showsCancelButton = false
        searchBar.text = nil
        view.endEditing(true)
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension DiscoverViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return discoverViewModel.rowCount
        case 1: return discoverViewModel.isLoading ? 1 : 0
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        endTyping()
        super.tableView(tableView, didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.discoverViewModel.loadMoreData(forIndex: indexPath.row) { [weak self] in
            self?.reloadTable()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 0 ? NewsItemCell.height : LoadingCell.height
    }
}

//MARK: - UISearchBarDelegate
extension DiscoverViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        filterButton.isHidden = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        endTyping()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        discoverViewModel.loadData(with: searchBar.text?.lowercased()) { [weak self] in
            self?.reloadTable()
        }
        endTyping()
    }
}
