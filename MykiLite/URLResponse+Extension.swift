//
//  URLResponse+Extension.swift
//  MykiLite
//
//  Created by Ali Fakih on 10/22/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation
import Foundation
extension URLResponse {
    var responseCode: Int? {
        guard let httpResponse = self as? HTTPURLResponse else { return nil }
        return httpResponse.statusCode
    }

    var headersField: JsonDictionary? {
        guard let httpResponse = self as? HTTPURLResponse, let dictionary = httpResponse.allHeaderFields as? JsonDictionary else { return nil }
        return dictionary
    }
}
