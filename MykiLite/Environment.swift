//
//  Environment.swift
//  NumberBook
//
//  Created by Miguel Bou Sleiman on 3/19/19.
//  Copyright © 2019 Miguel Bou Sleiman. All rights reserved.
//

import Foundation

public enum PlistKey {
    
    case serverURL
    
    func value() -> String {
        switch self {
        case .serverURL:
            return "APP_URL"
        }
    }
    
}

public struct Environment {
    
    fileprivate var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            } else {
                fatalError("Plist file not found")
            }
        }
    }
    
    public func configuration(_ key: PlistKey) -> String {
        return self.infoDict[key.value()] as! String
    }
    
}
