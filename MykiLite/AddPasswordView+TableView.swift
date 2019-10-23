//
//  AddPasswordView+TableView.swift
//  MykiLite
//
//  Created by Awwad on 8/14/19.
//  Copyright © 2019 myki. All rights reserved.
//

import UIKit

extension AddPasswordViewController {

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfCells
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let field = viewModel.fields[indexPath.row]
    switch field.type {
    case .header:
      return getHeaderCell(indexPath: indexPath)
    default:
      return getFieldCell(indexPath: indexPath)
    }
  }

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let field = viewModel.fields[indexPath.row]
    switch field.type {
    case .header:
      return 120
    default:
      return 80
    }
  }

  func getHeaderCell(indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! PasswordHeaderCellView
    cell.selectionStyle = .none
    cell.clipsToBounds = true
    return cell
  }

  func getFieldCell(indexPath: IndexPath) -> UITableViewCell {
    let field = viewModel.fields[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailCellView
    cell.titleLabel.text = field.title.rawValue
    cell.fieldType = field.title
    cell.detailTextField.text = field.value
    cell.detailTextField.isSecureTextEntry = field.isSecure

    cell.clipsToBounds = true
    cell.selectionStyle = .none
    cell.detailTextField.tintColor = .mykiGreen
    cell.infoBackgroundView.backgroundColor = .darkGray
    cell.detailTextField.autocapitalizationType = .none
    cell.detailTextField.keyboardAppearance = .dark

    cell.detailTextField.delegate = self
    cell.detailTextField.addTarget(self, action: #selector(self.textFieldChanged(_:)), for: .editingChanged)
    cell.detailTextField.tag = indexPath.row

    return cell
  }

}
