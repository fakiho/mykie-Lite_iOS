//
//  PasswordsViewController.swift
//  MykiLite
//
//  Created by Awwad on 8/13/19.
//  Copyright © 2019 myki. All rights reserved.
//

import UIKit

class PasswordsViewController: UITableViewController {

    var viewModel: PasswordsViewModel!

    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.barStyle = .black
        if #available(iOS 11.0, *) {
            let searchBar = searchController.searchBar
            searchBar.tintColor = UIColor.white
            searchBar.barTintColor = UIColor.white
            searchBar.searchTextField.textColor = .white
            if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
                textfield.textColor = .white
            if let backgroundView = textfield.subviews.first {
                        
                    // Background color
                    backgroundView.backgroundColor = UIColor.red
            
                    // Rounded corner
                    backgroundView.layer.cornerRadius = 10;
                    backgroundView.clipsToBounds = true;
                }
            }
            if let navigationBar = self.navigationController?.navigationBar {
                navigationBar.barTintColor = UIColor.black
            }
        }
        return searchController
    }()
    
  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel = PasswordsViewModel()
    configureNavBar()
    configureView()
    registerTableCell()
  }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

  @objc func addPassword() {
    let controller = AddPasswordViewController()
    self.navigationController?.pushViewController(controller, animated: true)
  }
    
    func editPassword(uuid: String) {
        let controller = AddPasswordViewController()
        controller.uuid = uuid
        self.navigationController?.pushViewController(controller, animated: true)
    }

  func configureNavBar() {
        self.title = "Passwords"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPassword))
        self.customizeSearchBar()
    }
    
    func customizeSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func registerTableCell() {
        self.tableView.register(PasswordCellView.self, forCellReuseIdentifier: "PasswordCellView")
    }
    
  func configureView() {
    self.view.backgroundColor = .darkGray
    self.tableView.separatorStyle = .none
    self.tableView.register(PasswordCellView.self, forCellReuseIdentifier: "cell")
  }
}
