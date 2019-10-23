//
//  PasswordsView+TableView.swift
//  MykiLite
//
//  Created by Awwad on 8/14/19.
//  Copyright © 2019 myki. All rights reserved.
//

import UIKit

extension PasswordsViewController {

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltering {
        return filteredPassword.count
    }
    
    return viewModel.numberOfCells
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordCellView", for: indexPath) as! PasswordCellView
    cell.itemBackView.backgroundColor = .navBar
    var password: Password
    if isFiltering {
        password = filteredPassword[indexPath.row]
    } else {
        password = viewModel.getPassword(row: indexPath.row)
    }
    cell.setupContent(password: password, client: client)
    cell.selectionStyle = .none
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell: PasswordCellView = tableView.cellForRow(at: indexPath) as! PasswordCellView
    let password = viewModel.getPassword(row: indexPath.row)
    print(password.url)
    //getPassword(row: indexPath)
    //editPassword()
  }

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }

}
