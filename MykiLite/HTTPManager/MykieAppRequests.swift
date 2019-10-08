//
//  MykieAppRequests.swift
//  MykiLite
//
//  Created by Miguel Bou Sleiman on 10/8/19.
//  Copyright © 2019 myki. All rights reserved.
//

enum UrlPath {
    case isPwned(password: String)
    
    func getPath() -> String {
        
        switch self {
        case .isPwned(let password):
            return "range/\(password)"
        }
        
    }
}

enum MykieAppRequests: HTTPRequestBuilder {
    
    case isPwned(password: String)
    
    // MARK: Path
    
    internal var path: UrlPath {
        switch self {
        case .isPwned(let password):
            return .isPwned(password: password)
        }
    }
    
    //MARK: Headers
    
    internal var headers: [String: String] {
        return defaultHeader
    }
    
    // MARK: Parameters
    
    internal var parameters: [String: Any] {
        
        switch self {
        case .isPwned:
            return  [String: Any]()
        }
        
    }
    
    // MARK: - HTTP Methods
    
    internal var httpMethod: HTTPMethod {
        switch self {
        case .isPwned:
            return .get
        }
    }
    
    
}
