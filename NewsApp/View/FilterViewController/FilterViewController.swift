//
//  FilterViewController.swift
//  NewsApp
//
//  Created by Marta Korol on 12.08.2023.
//

import UIKit

final class FilterViewController: UIViewController {

    static let identifier = "FilterViewController"
    
    private let tableView = UITableView()
    private let viewModel = FilterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filters"
        view.backgroundColor = .systemBackground
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: FilterItemCell.identifier, bundle: nil),
                           forCellReuseIdentifier: FilterItemCell.identifier)
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterItemCell.identifier, for: indexPath) as? FilterItemCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.getFilterCase(forIndex: indexPath.row))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let picker = PickerViewController()
        picker.viewModel = viewModel.getPickerViewModel(forIndex: indexPath.row)
        navigationController?.pushViewController(picker, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       FilterItemCell.height
    }
}
