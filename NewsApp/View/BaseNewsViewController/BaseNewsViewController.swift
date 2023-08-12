//
//  BaseNewsViewController.swift
//  NewsApp
//
//  Created by Marta Korol on 12.08.2023.
//

import UIKit

class BaseNewsViewController: UIViewController {
    
    let refreshControl = UIRefreshControl()
    var viewModel: TableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        refreshData()
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setupTableView() {
        view.backgroundColor = .systemBackground
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    func updateUI() {}
    func reloadTable() {}
    @objc func refreshData() {}
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension BaseNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsItemCell.identifier, for: indexPath) as? NewsItemCell,
                  let cellModel = viewModel.getCellViewModel(forIndex: indexPath.row)
            else {
                return UITableViewCell()
            }
            cell.configure(with: cellModel)
            cell.refreshUICallback = { [weak self] in
                self?.updateUI()
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.identifier, for: indexPath) as? LoadingCell else {
                return UITableViewCell()
            }
            cell.separatorInset = UIEdgeInsets(top: 0, left: cell.frame.width, bottom: 0, right: 0)
            cell.startAnimating()
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let url = viewModel.getWebViewURL(forIndex: indexPath.row) {
            let webView = WebViewController()
            webView.webUrl = url
            navigationController?.pushViewController(webView, animated: true)
        } else {
            showAlert(
                title: "Ooops..",
                message: "Something went wrong. We cannot open the page right now. Please try again later.",
                actionTitles: ["OK"]
            )
        }
    }
}
