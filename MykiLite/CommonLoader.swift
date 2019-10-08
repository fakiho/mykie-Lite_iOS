//
//  CommonLoader.swift
//  MykiLite
//
//  Created by Miguel Bou Sleiman on 10/8/19.
//  Copyright © 2019 myki. All rights reserved.
//

import ZVProgressHUD

protocol CommonLoader: NSObject {
    func presentLoader()
    func dismissLoader()
}

//MARK: Implementation

extension CommonLoader where Self: UIViewController {
    
    func presentLoader() {
        DispatchQueue.main.async {
            ZVProgressHUD.show()
        }
    }
    
    func dismissLoader() {
        DispatchQueue.main.async {
            ZVProgressHUD.dismiss()
        }
    }
    
}
