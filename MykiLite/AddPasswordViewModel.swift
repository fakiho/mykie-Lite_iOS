//
//  AddPasswordViewModel.swift
//  MykiLite
//
//  Created by Awwad on 8/14/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation
enum Fields: String {
    case nickName = "NickName"
    case userName = "UserName | Email"
    case password = "Password"
    case website = "Website"
    case header = "Header"
    
    func getKey() -> String {
        switch self {
        
        case .nickName:
            return "nickname"
        case .userName:
            return "username"
        case .password:
            return "password"
        case .website:
            return "website"
        case .header:
            return ""
        }
    }
}

class AddPasswordViewModel {

  var password: Password!
  var fields: [Field] = []
    var uuid: String?
  var numberOfCells: Int {
    return fields.count
  }

  init() {
    prepareFields()
  }

  func prepareFields() {
    let items: [NSDictionary] = [["title": Fields.header, "type": FieldTypes.header, "secure": false], ["title": Fields.nickName, "type": FieldTypes.text, "secure": false], ["title": Fields.userName, "type": FieldTypes.text, "secure": false], ["title": Fields.password, "type": FieldTypes.password, "secure": true], ["title": Fields.website, "type": FieldTypes.text, "secure": false]]

    for item in items {
      guard let title = item["title"] as? Fields, let type = item["type"] as? FieldTypes, let isSecure = item["secure"] as? Bool else { continue }
      fields.append(Field(title: title, type: type, isSecure: isSecure))
    }
    guard uuid != nil else {
        return
    }
    
    getPassword()
  }

  func updatePassword(item: NSDictionary) {
    password = Password(object: item)
  }
    
    func getPassword() {
        print(database.fetch(with: getByUUID(uuid: uuid ?? "")))
    }
    
    func getByUUID(uuid: String) -> FetchRequest<[Password], PasswordObject> {
           return FetchRequest<[Password], PasswordObject>(predicate: NSPredicate(format: "uuid = %@", uuid), sortDescriptors: [], transformer: { $0.map(Password.init) })
       }

}
