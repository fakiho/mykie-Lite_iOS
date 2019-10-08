//
//  HTTPRequestBuilder.swift
//  MykiLite
//
//  Created by Miguel Bou Sleiman on 9/2/19.
//  Copyright © 2019 Miguel Bou Sleiman. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol HTTPRequestBuilder {
    var baseUrl: String { get }
    var path: UrlPath { get }
    var finalUrl: URL { get }
    var headers: [String: String] { get }
    var parameters: [String: Any] { get }
    var httpMethod: HTTPMethod { get }
    var encoding: HTTPEncoding { get }
}

extension HTTPRequestBuilder {
    
    var baseUrl: String {
        return Environment().configuration(.serverURL)
    }
    
    var defaultHeader: [String: String] {
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        return headers
    }
    
    var encoding: HTTPEncoding {
        switch httpMethod {
        case .get:
            return .url
        default:
            return .json
        }
    }
    
    var finalUrl: URL {
        return URL(string: baseUrl)!.appendingPathComponent(path.getPath())
    }
    
    var urlRequest: URLRequest {
        
        var request = URLRequest(url: finalUrl)
        request.httpMethod = httpMethod.rawValue
        
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        request.httpMethod  = httpMethod.rawValue
        request.encode(with: parameters, type: encoding)
        
        return request
    }
    
    func asURLRequest() throws -> URLRequest {
        return urlRequest
    }
    
    
}
