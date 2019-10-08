//
//  AddPasswordViewModel.swift
//  MykiLite
//
//  Created by Awwad on 8/14/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation
import UIKit

protocol AddPasswordViewModelDelegate: class {
    func reloadView()
    func shouldDismissView()
    func showPopUp(with title: String, message: String)
    func showAlert(with title: String, message: String, completion: (() -> Void)?) 
}

enum AddPasswordModelType {
    case add
    case edit
}

class AddPasswordViewModel {
    
    var type: AddPasswordModelType? = .add
    
    weak var delegate: AddPasswordViewModelDelegate?
    
    var title: String?
    var password: Password?
    
    var fieldHeader: Field!
    var fieldNickname: Field!
    var fieldUsername: Field!
    var fieldPassword: Field!
    var fieldWebsite: Field!
    
    var fields: [Field] = []
    
    var numberOfCells: Int {
        return fields.count
    }
    
    init(delegate: UIViewController) {
        self.delegate = delegate as? AddPasswordViewModelDelegate
        self.title = "Add Password"
        prepareFields()
    }
    
    func prepareFields() {
        //since those are static, its better to just create an item for each to directly access the value
        fieldHeader   = Field(title: "Header", type: .header, isSecure: false, isEditable: true, canCopy: false)
        fieldNickname = Field(title: "Nickname", type: .text, isSecure: false, isEditable: true, canCopy: false)
        fieldUsername = Field(title: "Username | Email", type: .text, isSecure: false, isEditable: true, canCopy: false)
        fieldPassword = Field(title: "Password", type: .password, isSecure: true, isEditable: true, canCopy: false)
        fieldWebsite  = Field(title: "Website", type: .text, isSecure: false, isEditable: true, canCopy: false)
        
        fields = [fieldHeader, fieldNickname, fieldUsername, fieldPassword, fieldWebsite]
    }
    
    func isValid() -> Bool {
        
        //check if all required fields are valid
        
        guard !self.fieldNickname.value.isNull() else {
            self.delegate?.showPopUp(with: "Error", message: "Kindly enter a nickname!")
            return false
        }
        
        guard !self.fieldUsername.value.isNull() else {
            self.delegate?.showPopUp(with: "Error", message: "Kindly enter a username!")
            return false
        }
        
        guard !self.fieldPassword.value.isNull() else {
            self.delegate?.showPopUp(with: "Error", message: "Kindly enter a password!")
            return false
        }
        
        return true
    }
    
    func updatePassword() {
        
        guard isValid() else { return }
        
        password = Password(uuid: (password?.uuid.isNull() ?? true) ? UUID().uuidString.lowercased() : password!.uuid,
                            nickname: fieldNickname.value,
                            username: fieldUsername.value,
                            password: fieldPassword.value,
                            url: fieldWebsite.value)
        
        database.createOrUpdate(model: password!, with: PasswordObject.init)
        self.delegate?.shouldDismissView()
        
    }
    
    func didPressNavButton() {
        updatePassword()
    }
    
}
