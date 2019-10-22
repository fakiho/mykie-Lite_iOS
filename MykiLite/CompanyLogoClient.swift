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
    
    /// Initialize Wallet Client
    /// - Parameter dataProvider: Responsible for creating a secure request from one place and where it can handle all the authentications
    /// - Parameter baseURL: The base url used to make changing it easy for a specific client
    public init(dataProvider: DBSDataProvider?, baseURL: URL) {
        self.dataProvider = dataProvider
        self.baseURL = baseURL
    }
}
extension CompanyLogoClient: CompanyLogoClientProtocol {
    public func getLogo(domain: String, completion: @escaping (UIImage?, Error?) -> Void) {
        let urlComponent = URLComponents(string: baseURL.appendingPathComponent("\(domain)").absoluteString)
        guard let url = urlComponent?.url else {completion(nil, NSError(domain: "", code: 0110, userInfo: ["domain" : baseURL])); return}
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        dataProvider?.execute(request, completionHandler: { (_, data, error) in
            guard let data = data else { completion(nil, error); return}
            let image = UIImage(data: data)
            completion(image, error)
        })
    }
    
    
}
