//
//  Field.swift
//  MykiLite
//
//  Created by Awwad on 8/14/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation

struct Field {
  var title: Fields
  var type: FieldTypes
  var isSecure: Bool
  var value = ""

  init(title: Fields, type: FieldTypes, isSecure: Bool) {
    self.title = title
    self.type = type
    self.isSecure = isSecure
  }
}

enum FieldTypes: Int {
  case text
  case password
  case header
}
