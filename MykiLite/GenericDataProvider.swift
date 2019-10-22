//
//  GenericDataProvider.swift
//  MykiLite
//
//  Created by Ali Fakih on 10/22/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation
import Foundation
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

public class GenericClientDataProvider: NSObject, DBSDataProvider {
    public func execute(_ request: URLRequest, completionHandler: ((URLResponse?, Data?, Error?) -> Void)?) {
        guard let completionHandler = completionHandler else {return}
        makeRequest(request, completionHandler: completionHandler)
    }
}

extension GenericClientDataProvider {
    private func makeRequest(_ request: URLRequest, completionHandler: ((URLResponse?, Data?, Error?) -> Void)? = nil) {
        guard let completionHandler = completionHandler else { return }
        DispatchQueue.global(qos: .background).async {
            var finalRequest = request
            finalRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            finalRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            finalRequest.setValue("Bearer sk_test_XKokBfNWv6FIYuTMg5sLPjhJ", forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: finalRequest) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse else {
                    self.createErrorOrSuccessResponse(response: response, data: data, error: error)
                    return
                }
                switch httpResponse.statusCode {
                case 401:
                    let errorTemp = NSError(domain: "", code: httpResponse.statusCode, userInfo: data?.jsonObject)
                    DispatchQueue.main.async {
                        completionHandler(response, data, errorTemp)
                    }
                default:
                    guard (200 ... 299).contains(httpResponse.statusCode) else {
                        self.createErrorOrSuccessResponse(response: httpResponse, data: data, error: error)
                        return
                    }
                    print(httpResponse.statusCode)
                    self.createErrorOrSuccessResponse(response: httpResponse, data: data, error: error,completionHandler: completionHandler)
                }
            }
            task.resume()
        }
    }
    
    private func createErrorOrSuccessResponse(response: URLResponse?, data: Data?, error: Error?, completionHandler: ((URLResponse?, Data?, Error?) -> Void)? = nil) {
        var error = error
        if let data = data, let json = data.jsonObject, let message = json["message"], error == nil {
            error = NSError(domain: "", code: response?.responseCode ?? 0, userInfo: ["message" : message as Any])
        }
        DispatchQueue.main.async {
            completionHandler?(response, data, error)
        }
        
    }
}
