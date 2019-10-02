//
//  String+Extras.swift
//  MykiLite
//
//  Created by Miguel Bou Sleiman on 9/30/19.
//  Copyright © 2019 myki. All rights reserved.
//

import UIKit

extension String {
    
    func isNull() -> Bool {
        var string = self
        string = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if (string == "") {
            return true
        }
        return false
    }
    
    func copyToClipboard() {
        UIPasteboard.general.string = self
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var logoUrl: String {
        return "https://logo.clearbit.com/\(self)"
    }
    
}
