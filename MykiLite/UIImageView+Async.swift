//
//  UIImageView+Async.swift
//  MykiLite
//
//  Created by Miguel Bou Sleiman on 9/30/19.
//  Copyright © 2019 myki. All rights reserved.
//

import UIKit

extension UIImageView {
    
    //Wrapper over SDWebImage
    
    func loadImg(with url: String, placeholder: UIImage?, completion: @escaping (Error?, UIImage?) -> Void) {
        
        self.image = placeholder
        
        guard let url = URL(string: url) else {
            return
        }
        
        HTTPManager.downloadImg(with: url) { (image, error, isFromCache) in
            if image != nil && error == nil {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
        
    }
    
}
