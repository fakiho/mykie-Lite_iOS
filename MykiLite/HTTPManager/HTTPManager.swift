//
//  HTTPRequest.swift
//  MykiLite
//
//  Created by Miguel Bou Sleiman on 12/1/18.
//  Copyright © 2018 Miguel Bou Sleiman. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()
var loadingImgs = [String : Int]()

enum HTTPManagerError: Int, Error {
    
    case success = 200
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound  = 404
    case manyRequests = 429
    case unavailable = 503
    case error = -1
    
    func getMessage() -> String {
        
        switch self {
        case .success:
            return ""
            
        case .badRequest:
            return "Bad Request!"
            
        case .unauthorized:
            return "Unauthorized!"
            
        case .forbidden:
            return "Forbidden!"
            
        case .notFound:
            return "Not Found!"
            
        case .manyRequests:
            return "Many Request!"
            
        case .unavailable:
            return "Unavailable!"
            
        default:
            return "An error occured, please try again later!"
        }
        
    }
}

class HTTPManager {
    
    class func handle(request: HTTPRequestBuilder, completion: @escaping (Swift.Result<Any, HTTPManagerError>)->Void?) {
        
        let task = URLSession.shared.dataTask(with: request.urlRequest) { (data, response, error) in
            
            guard error == nil, let data = data, let response = response as? HTTPURLResponse else {
                completion(.failure(.error))
                return
            }
            
            let error = HTTPManagerError(rawValue: response.statusCode)
            
            guard error != nil else {
                completion(.failure(.error))
                return
            }
            
            guard error == .success else {
                completion(.failure(error!))
                return
            }
            
            let responseString = String(decoding: data, as: UTF8.self)
            completion(.success(responseString))
            
        }
        
        task.resume()
        
    }
    
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
