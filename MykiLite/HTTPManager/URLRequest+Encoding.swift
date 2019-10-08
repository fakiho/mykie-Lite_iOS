//
//  HTTPEncoding.swift
//  MykiLite
//
//  Created by Miguel Bou Sleiman on 10/7/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation

enum HTTPEncoding {
    case url
    case json
}

enum HTTPEncodingError: Error {
    case jsonError
    case invalidUrl
}

extension URLRequest {
    
    mutating func encode(with parameters: [String: Any], type: HTTPEncoding) {
        switch type {
        case .url:
            self.encodeUrl(with: parameters)
        case .json:
            self.encodeJson(with: parameters)
        }
    }
    
    mutating private func encodeUrl(with parameters: [String: Any]) {
        
        guard parameters.count > 0 else { return }
        
        var urlString = self.url?.absoluteString ?? ""
        
        var queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: "\(value)"))
        }
        
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = queryItems
        urlString = urlComponents?.url?.absoluteString ?? ""
        
        self.url = URL(string: urlString)
        
    }
    
    mutating private func encodeJson(with parameters: [String: Any]) {
        if let data = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            self.httpBody = data
        }
    }
    
}
