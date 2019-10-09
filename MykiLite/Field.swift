//
//  Field.swift
//  MykiLite
//
//  Created by Awwad on 8/14/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation

class Field: NSObject {
    var title: String
    var type: FieldTypes
    var isSecure: Bool
    var value: String {
        didSet {
            didSetCompletion?(value)
        }
    }
    var isEditable: Bool
    var isCopyable: Bool
    var didSetCompletion: ((String) -> Void)?
    
    init(title: String, type: FieldTypes, isSecure: Bool, isEditable: Bool, canCopy: Bool) {
        self.value = ""
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
