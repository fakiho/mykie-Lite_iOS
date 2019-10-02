//
//  CommonAlert.swift
//  MykiLite
//
//  Created by Miguel Bou Sleiman on 10/1/19.
//  Copyright © 2019 myki. All rights reserved.
//

import UIKit
import CRNotifications

enum AlertType {
    case error
    case success
    case info
}

protocol CommonAlert {
    func showPopUp(with type: AlertType, title: String, message: String)
}

extension CommonAlert where Self: UIViewController {
    
    func showPopUp(with type: AlertType, title: String, message: String) {
        CRNotifications.showNotification(textColor: .mykiGreen,
                                         backgroundColor: .black,
                                         image: nil,
                                         title: title,
                                         message: message,
                                         dismissDelay: 2)
    }
    
    func showAlert(with title: String, message: String, handler: (() -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let confirmAction = UIAlertAction(title: "Confirm".localized, style: .default) { (action) in
            handler?()
        }
        
        let dismissAction = UIAlertAction(title: "Dismiss".localized, style: UIAlertAction.Style.default)
        
        alert.addAction(confirmAction)
        alert.addAction(dismissAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
