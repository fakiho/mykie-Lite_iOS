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
        let field = viewModel.fields[indexPath.row]
        cell.setCell(with: field.value)
        return cell
    }
    
    func getFieldCell(indexPath: IndexPath) -> UITableViewCell {
        let field = viewModel.fields[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailCellView
        
        cell.delegate = self
        
        cell.titleLabel.text = field.title.localized
        cell.detailTextField.text = field.value
        cell.detailTextField.isSecureTextEntry = field.isSecure
        cell.btnCopy.isHidden = !field.isCopyable
        cell.detailTextField.isUserInteractionEnabled = field.isEditable
        
        cell.detailTextField.delegate = self
        cell.detailTextField.addTarget(self, action: #selector(self.textFieldChanged(_:)), for: .editingDidEnd)
        cell.detailTextField.tag = indexPath.row
        
        return cell
    }
    
}

//MARK: DetailCellViewDelegate

extension AddPasswordViewController: DetailCellViewDelegate {
    
    func didPressCopyButton(in cell: DetailCellView) {
        
        guard let index = self.tableView.indexPath(for: cell) else {
            return
        }
        
        let field = self.viewModel.fields[index.row]
        field.value.copyToClipboard()
        self.showPopUp(with: .info,
                       title: "Success".localized,
                       message: "Your password has been copied to the clipboard!".localized)
        
    }
    
}
