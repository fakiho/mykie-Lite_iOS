//
//  CompanyLogoClient.swift
//  MykiLite
//
//  Created by Ali Fakih on 10/22/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation
import UIKit

public class CompanyLogoClient: NSObject, DBSClient {
    public var dataProvider: DBSDataProvider?
    public var baseURL: URL
    public var saveHelper: SaveHelper = SaveHelper()
    /// Initialize Wallet Client
    /// - Parameter dataProvider: Responsible for creating a secure request from one place and where it can handle all the authentications
    /// - Parameter baseURL: The base url used to make changing it easy for a specific client
    public init(dataProvider: DBSDataProvider?, baseURL: URL = URL(string: "https://logo.clearbit.com/")!) {
        self.dataProvider = dataProvider
        self.baseURL = baseURL
    }
}
extension CompanyLogoClient: CompanyLogoClientProtocol {
    
    /// Call Clearbit Service and try to get the domain logo provided by the user
    /// here you can see two ways to cache:
    /// -1 Saving in memory as temporary but it need to be handed specially if there's a huge amount of data so it need to be carefully monitored and clear when it necessary
    /// 2- Saving internally less memory usage but it take space on the disk storage but for this case i think it's the best way specially there's no huge amount of images to download plus the image quality is
    /// low it won't take a large space and also won't take too long to read-write on the disk (small size)
    /// - Parameter domain: the website user entered for
    /// - Parameter completion: a way to callback when the session is completed escaping with an optional image and error if exist
    public func getLogo(domain: String, completion: @escaping (UIImage?, Error?) -> Void) {
        let urlComponent = URLComponents(string: baseURL.appendingPathComponent("\(domain)").absoluteString)
        guard let url = urlComponent?.url else {completion(nil, NSError(domain: "", code: 0110, userInfo: ["domain" : baseURL])); return}
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        if (imageCache.object(forKey: domain as AnyObject) != nil) {
            print("Cached image used, no need to download it")
            let image = imageCache.object(forKey: (domain as AnyObject)) as? UIImage
                completion(image, nil)
        }
        guard (saveHelper.retrieveImage(forKey: domain, inStorage: StorageType.fileSystem) != nil) else {
            dataProvider?.execute(request, completionHandler: { (_, data, error) in
                guard let data = data else { completion(nil, error); return}
                guard let image = UIImage(data: data) else {completion(nil, error); return}
                self.saveHelper.store(image: image, forKey: domain, withStorageType: StorageType.fileSystem)
                imageCache.setObject(image, forKey: domain as AnyObject)
                completion(image, error)
            })
            return
        }
        let image = saveHelper.retrieveImage(forKey: domain, inStorage: StorageType.fileSystem)
        completion(image, nil)
        
    }
    
    
}
