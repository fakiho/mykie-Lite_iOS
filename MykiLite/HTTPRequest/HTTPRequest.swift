//
//  HTTPRequest.swift
//  Photify
//
//  Created by Miguel Bou Sleiman on 12/1/18.
//  Copyright © 2018 Miguel Bou Sleiman. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()
var loadingImgs = [String : Int]()

class HTTPRequest {
    
    class func downloadImg(with url: URL, completion: @escaping (_ image: UIImage?, _ error: Error?,_ fromCache: Bool) -> Void) {
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage, nil, true)
        } else {
            
            if (loadingImgs[url.absoluteString] != 1) {
                loadingImgs[url.absoluteString] = 1
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    
                    loadingImgs[url.absoluteString] = nil
                    
                    guard error == nil else {
                        completion(nil, error, false)
                        return
                    }
                    
                    guard let data = data, let image = UIImage(data: data) else {
                        completion(nil, nil, false)
                        return
                    }
                    
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    completion(image, nil, false)
                    
                    
                }
                
                task.resume()
            }
        }
        
    }
    
}
