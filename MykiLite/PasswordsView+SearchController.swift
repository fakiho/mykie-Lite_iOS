//
//  PasswordsView+SearchController.swift
//  MykiLite
//
//  Created by Miguel Bou Sleiman on 10/1/19.
//  Copyright © 2019 myki. All rights reserved.
//

import UIKit

//MARK: SearchResultsUpdating

extension PasswordsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterPasswords(with: searchController.searchBar.text ?? "")
    }
    
    func filterPasswords(with text: String) {
        if text.isNull() {
            self.viewModel.didEndSearch()
        } else {
            self.viewModel.didSearch(with: text)
        }
    }
    
}

//MARK: SearchBarDelegate

extension PasswordsViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.didEndSearch()
    }
}

//MARK: ViewModelDelegatem

extension PasswordsViewController: PasswordsViewModelDelegate {
    func reloadView() {
        self.tableView.reloadData()
    }
}
