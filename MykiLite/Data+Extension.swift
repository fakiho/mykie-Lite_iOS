//
//  Data+Extension.swift
//  MykiLite
//
//  Created by Ali Fakih on 10/22/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation
typealias JsonDictionary = [String : Any]
extension Data {
    var jsonObject: JsonDictionary? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: .allowFragments) as? JsonDictionary
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
}
