//
//  UIImageView+Async.swift
//  MykiLite
//
//  Created by Miguel Bou Sleiman on 9/30/19.
//  Copyright © 2019 myki. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    //Wrapper over SDWebImage
    
    func loadImg(with url: String, placeholder: UIImage?, completion: @escaping (Error?, UIImage?) -> Void) {
        
        guard let url = URL(string: url) else {
            self.image = placeholder
            return
        }
        
        self.sd_setImage(with: url, placeholderImage: placeholder, options: []) { (image, error, cacheType, url) in
            completion(error, image)
        }
        
    }
    
}
