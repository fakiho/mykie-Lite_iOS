//
//  AddPasswordViewController+ViewModelDelegate.swift
//  MykiLite
//
//  Created by Miguel Bou Sleiman on 9/30/19.
//  Copyright © 2019 myki. All rights reserved.
//

import UIKit

extension AddPasswordViewController: AddPasswordViewModelDelegate {
    
    func shouldDismissView() {
        self.popView(animated: true)
    }
    
    func showPopUp(with title: String, message: String) {
        self.showPopUp(with: .error, title: title.localized, message: message.localized)
    }
    
    func reloadView() {
        if let vModel = self.viewModel as? EditPasswordViewModel {
            self.btnEditSave.isSelected = !vModel.isEditing
        }
        self.tableView.reloadData()
    }
    
    func showAlert(with title: String, message: String, completion: (() -> Void)?) {
        self.showAlert(with: title, message: message, handler: completion)
    }
    
}
