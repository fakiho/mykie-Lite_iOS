//
//  EditPasswordViewModel.swift
//  MykiLite
//
//  Created by Miguel Bou Sleiman on 10/2/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation

class EditPasswordViewModel: AddPasswordViewModel {
    
    var isEditing: Bool = false
    
    override init(delegate: AddPasswordViewModelDelegate, db: Database) {
        super.init(delegate: delegate, db: db)
        self.title = ""
        self.type = .edit
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
        
        guard password != nil else { return }
        
        self.delegate?.showAlert(with: "Alert".localized, message: "Are you sure you want to delete this password?", completion: {
            [weak self] in
            self?.database.delete(type: PasswordObject.self, with: self?.password?.uuid ?? "")
            
            NotificationCenter.default.post(name: NSNotification.Name(kPasswordNotification), object: nil)
            //            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            //                self?.delegate?.shouldDismissView()
            //            }
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
