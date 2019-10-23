//
//  Password.swift
//  MykiLite
//
//  Created by Awwad on 8/14/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation

struct Password {
  var uuid: String = ""
  var nickname: String = ""
  var username: String = ""
  var password: String = ""
  var url: String = ""
}

extension Password {
  init(object: PasswordObject) {
    self.uuid = object.uuid
    self.nickname = object.nickname
    self.username = object.username
    self.password = object.password
    self.url = object.url
  }

  init(object: NSDictionary) {
    if let uuid = object["uuid"] as? String {
      self.uuid = uuid
    }

    if let nickname = object["nickname"] as? String {
      self.nickname = nickname
    }

    if let username = object["username"] as? String {
      self.username = username
    }

    if let password = object["password"] as? String {
      self.password = password
    }

    if let url = object["url"] as? String {
      self.url = url
    }
  }
    
    func getValue(by field: Fields) -> String {
        switch field {
        case .header:
            return url
        case .nickName:
            return nickname
        case .userName:
            return username
        case .password:
            return password
        case .website:
            return url
        }
    }
}
