//
//  PasswordsViewController.swift
//  MykiLite
//
//  Created by Awwad on 8/13/19.
//  Copyright © 2019 myki. All rights reserved.
//

import UIKit

class PasswordsViewController: UITableViewController, MykiRouter {
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureView()
        self.viewModel.fetchPasswords()
    }
    
    @objc func addPassword() {
        self.push(self.viewModel.getAddPasswordRoute())
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
