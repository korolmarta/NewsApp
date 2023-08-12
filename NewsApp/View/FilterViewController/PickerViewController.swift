//
//  PickerViewController.swift
//  NewsApp
//
//  Created by Marta Korol on 12.08.2023.
//

import UIKit

class PickerViewController: UIViewController {
    
    static let identifier = "PickerViewController"
    
    private let tableView = UITableView()
    var viewModel: PickerViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Items"
        view.backgroundColor = .systemBackground
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: OptionCell.identifier, bundle: nil),
                           forCellReuseIdentifier: OptionCell.identifier)
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension PickerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OptionCell.identifier, for: indexPath) as? OptionCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.opions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectItem(withIndex: indexPath.row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        OptionCell.height
    }
}
