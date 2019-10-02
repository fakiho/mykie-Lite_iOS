//
//  EditPasswordViewModel.swift
//  MykiLite
//
//  Created by Miguel Bou Sleiman on 10/2/19.
//  Copyright © 2019 myki. All rights reserved.
//

import UIKit

class EditPasswordViewModel: AddPasswordViewModel {
    
    var isEditing: Bool = false
    
    override init(delegate: UIViewController) {
        super.init(delegate: delegate)
        self.title = ""
    }
    
    override func prepareFields() {
        super.prepareFields()
        self.fieldUsername.isCopyable = true
        self.fieldPassword.isCopyable = true
        updateFields()
    }
    
    func updateFields() {
        self.fieldUsername.isEditable = isEditing
        self.fieldNickname.isEditable = isEditing
        self.fieldPassword.isEditable = isEditing
        self.fieldWebsite.isEditable = isEditing
    }
    
    func updateFields(with password: Password) {
        
        self.password = password
        
        self.fieldHeader.value = password.url.logoUrl
        self.fieldNickname.value = password.nickname
        self.fieldUsername.value = password.username
        self.fieldPassword.value = password.password
        self.fieldWebsite.value  = password.url
        
    }
    
    func deletePassword() {
        self.delegate?.showAlert(with: "Alert".localized, message: "Are you sure you want to delete this password?", completion: {
            [weak self] in
            database.delete(type: PasswordObject.self, with: self?.password?.uuid ?? "")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self?.delegate?.shouldDismissView()
            }
        })
    }
    
    override func didPressNavButton() {
        
        if isEditing {
            updatePassword()
        }
        
        isEditing = !isEditing
        updateFields()
        self.delegate?.reloadView()
        
    }
    
}
