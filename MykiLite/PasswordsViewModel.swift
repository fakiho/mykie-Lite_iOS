//
//  PasswordsViewModel.swift
//  MykiLite
//
//  Created by Awwad on 8/13/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation

class PasswordsViewModel {

  var passwords: [Password] {
    return database.fetch(with: Password.all)
  }

  var numberOfCells: Int {
    return passwords.count
  }

  func getPassword(row: Int) -> Password {
    return passwords[row]
  }
    
    func passwordFilter(by text: String?) -> [Password] {
        guard let searchText = text else {return []}
        return database.fetch(with: FetchRequest<[Password], PasswordObject>(predicate: NSPredicate(format: "email = %@ || nickname = %@", searchText, searchText), sortDescriptors: [], transformer: { $0.map(Password.init)}))
    }

}
