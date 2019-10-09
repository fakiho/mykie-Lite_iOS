//
//  MykiViewControllers.swift
//  MykiLite
//
//  Created by Miguel Bou Sleiman on 10/8/19.
//  Copyright © 2019 myki. All rights reserved.
//

import UIKit

enum MykiViewControllers {
    
    case passwordView
    case addPasswordView(type: AddPasswordModelType, password: Password?)
    
    func getVC() -> UIViewController {
        switch self {
        case .passwordView:
            return PasswordsViewController()
        case .addPasswordView(let type, let password):
            return getAddPassword(with: type, password: password)
        }
    }
    
    private func getAddPassword(with type: AddPasswordModelType, password: Password?) -> UIViewController {
        
        let addPasswordVC = AddPasswordViewController()
        var viewModel: AddPasswordViewModel?
        
        switch type {
        case .edit:
            let editViewModel = EditPasswordViewModel(delegate: addPasswordVC, db: database)
            if password != nil {
                editViewModel.updateFields(with: password!)
            }
            viewModel = editViewModel
            break
        case .add:
            viewModel = AddPasswordViewModel(delegate: addPasswordVC, db: database)
            break
        }
        
        addPasswordVC.viewModel = viewModel
        
        return addPasswordVC
    }
    
}
