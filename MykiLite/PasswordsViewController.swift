//
//  PasswordsViewController.swift
//  MykiLite
//
//  Created by Awwad on 8/13/19.
//  Copyright © 2019 myki. All rights reserved.
//

import UIKit

class PasswordsViewController: UITableViewController {
    
    lazy var viewModel: PasswordsViewModel = {
        let _viewModel = PasswordsViewModel(delegate: self)
        return _viewModel
    }()
    
    lazy var searchController: UISearchController = {
        let _searchController = UISearchController(searchResultsController: nil)
        _searchController.searchResultsUpdater = self
        _searchController.searchBar.delegate = self
        _searchController.dimsBackgroundDuringPresentation = false
        _searchController.view.backgroundColor = UIColor.clear
        definesPresentationContext = true
        _searchController.hidesNavigationBarDuringPresentation = false
        _searchController.searchBar.barTintColor = UIColor.groupTableViewBackground
        return _searchController
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.fetchPasswords()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureView()
    }
    
    @objc func addPassword() {
        let controller = AddPasswordViewController()
        let viewModel = AddPasswordViewModel(delegate: controller)
        viewModel.type = .add
        controller.viewModel = viewModel
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func edit(password: Password) {
        let controller = AddPasswordViewController()
        let viewModel = EditPasswordViewModel(delegate: controller)
        viewModel.type = .edit
        viewModel.updateFields(with: password)
        controller.viewModel = viewModel
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func configureNavBar() {
        self.title = viewModel.title.localized
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPassword))
        self.navigationItem.searchController = searchController
    }
    
    func configureView() {
        self.view.backgroundColor = .darkGray
        self.tableView.separatorStyle = .none
        self.tableView.register(PasswordCellView.self, forCellReuseIdentifier: "cell")
    }
    
}
