//
//  AddPasswordViewModel.swift
//  MykiLite
//
//  Created by Awwad on 8/14/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation

protocol AddPasswordViewModelDelegate: class {
    func showLoader()
    func hideLoader()
    func reloadView()
    func reloadTable(for row: Int)
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
    var database: Database
    
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
    
    init(delegate: AddPasswordViewModelDelegate, db: Database) {
        self.delegate = delegate
        self.database = db
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
        fieldWebsite.didSetCompletion = {
            [unowned self] (text) -> Void in
            guard self.fieldHeader.value != text.logoUrl else { return }
            self.fieldHeader.value = text.logoUrl
            self.delegate?.reloadTable(for: 0)
        }
        
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
    
    func checkIfPasswordLeaked(password: String, completion: @escaping (Bool, Bool) -> Void ) {
        
        self.delegate?.showLoader()
        
        let request = MykieAppRequests.isPwned(password: password.md5().substring(to: 5))
        
        HTTPManager.handle(request: request) {
            [unowned self] (results) -> Void in
            
            self.delegate?.hideLoader()
            
            switch results {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.showAlert(with: "Alert", message: error.getMessage(), completion: nil)
                    completion(false, false)
                }
                
            case .success(let response):
                
                guard let response = response as? String else {
                    self.delegate?.showPopUp(with: "Alert", message: "An error has occured, please try again later!")
                    completion(false, false)
                    return
                }
                
                let passwordsArr = response.components(separatedBy: CharacterSet.newlines)
                if passwordsArr.count > 0 {
                    DispatchQueue.main.async {
                        self.delegate?.showPopUp(with: "Alert", message: "Your password has been leaked \(passwordsArr.count)")
                    }
                }
                
                completion(true, passwordsArr.count > 0)
                
                break
            }
        }
    }
    
    func updatePassword() {
        
        guard isValid() else { return }
        
        self.checkIfPasswordLeaked(password: fieldPassword.value) {
            [unowned self] (shouldSavePass, isLeaked) in
            self.savePassword()
        }
        
    }
    
    func savePassword() {
        DispatchQueue.main.async {
            self.password = Password(uuid: (self.password?.uuid.isNull() ?? true) ? UUID().uuidString.lowercased() : self.password!.uuid,
                                     nickname: self.fieldNickname.value,
                                     username: self.fieldUsername.value,
                                     password: self.fieldPassword.value,
                                     url: self.fieldWebsite.value)
            
            self.database.createOrUpdate(model: self.password!, with: PasswordObject.init)
            
            NotificationCenter.default.post(name: NSNotification.Name(kPasswordNotification), object: nil)
            if self.type == .add  {
                self.delegate?.shouldDismissView()
            }
        }
    }
    
    func didPressNavButton() {
        updatePassword()
    }
    
}
