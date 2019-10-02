//
//  Field.swift
//  MykiLite
//
//  Created by Awwad on 8/14/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation

class Field {
    var title: String
    var type: FieldTypes
    var isSecure: Bool
    var value = ""
    var isEditable: Bool
    var isCopyable: Bool
    
    init(title: String, type: FieldTypes, isSecure: Bool, isEditable: Bool, canCopy: Bool) {
        self.title = title
        self.type = type
        self.isSecure = isSecure
        self.isEditable = isEditable
        self.isCopyable = canCopy
    }
}

enum FieldTypes: Int {
    case text
    case password
    case header
}
