//
//  PasswordsViewModel.swift
//  MykiLite
//
//  Created by Awwad on 8/13/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation
import UIKit

let kPasswordNotification = "DidUpdatePassword"

protocol PasswordsViewModelDelegate: class {
    func reloadView()
}

class PasswordsViewModel {
    
    weak var delegate: PasswordsViewModelDelegate?
    
    let title = "Passwords"
    
    private var isSearching = false
    private var filteredArray: [Password]?
    
    private var passwords: [Password]!
    //removed the fetching from the db on everycall, since its an unecessary call to get the same data many times, and instead, i'm updating from the db when needed
    
    init(delegate: UIViewController?) {
        self.delegate = delegate as? PasswordsViewModelDelegate
        self.setPasswordObserver()
    }
    
    func setPasswordObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdatePasswords(_ :)), name: NSNotification.Name(rawValue: kPasswordNotification), object: nil)
    }
    
    @objc func didUpdatePasswords(_ notification: NSNotification) {
        self.fetchPasswords()
    }
    
    func fetchPasswords() {
        passwords = database.fetch(with: Password.all)
        if !isSearching {
            self.delegate?.reloadView()
        }
    }
    
    var numberOfCells: Int {
        return isSearching ? filteredArray?.count ?? 0 : passwords.count
    }
    
    func getPassword(row: Int) -> Password? {
        return isSearching ? filteredArray?[row] : passwords[row]
    }
    
    func didEndSearch() {
        //state when not searching
        isSearching = false
        filteredArray  = nil
        self.delegate?.reloadView()
    }
    
    func didSearch(with text: String) {
        //update to searching state
        isSearching = true
        let txt = text.lowercased()
        
        //searching through the already obtained db array instead of fetching directly from the db, since we already have our data
        filteredArray = passwords.filter {
            (password) -> Bool in
            return password.nickname.contains(txt) || password.username.contains(txt)
        }
        
        //reload view
        self.delegate?.reloadView()
        
    }
    
    func editPassword(at index: Int) -> MykiViewControllers? {
        
        guard let password = self.getPassword(row: index) else {
            return nil
        }
        
        return MykiViewControllers.addPasswordView(type: .edit, password: password)
        
    }
    
    func getAddPasswordRoute() -> MykiViewControllers {
        return MykiViewControllers.addPasswordView(type: .add, password: nil)
    }
    
}
