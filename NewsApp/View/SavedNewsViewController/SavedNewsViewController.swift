//
//  SavedNewsViewController.swift
//  NewsApp
//
//  Created by Marta Korol on 11.08.2023.
//

import UIKit

final class SavedNewsViewController: BaseNewsViewController {
    
    static let identifier = "SavedNewsViewController"
    
    private var savedNewsViewModel: SavedNewsViewModel {
        return (viewModel as? SavedNewsViewModel) ?? SavedNewsViewModel()
    }
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SavedNewsViewModel()
    }
    
    override func setupTableView() {
        super.setupTableView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: NewsItemCell.identifier, bundle: nil),
                           forCellReuseIdentifier: NewsItemCell.identifier)
        
        tableView.refreshControl = refreshControl
    }
    
    override func updateUI() {
        super.updateUI()
        refreshData()
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
        savedNewsViewModel.loadData()
        reloadTable()
    }
}
