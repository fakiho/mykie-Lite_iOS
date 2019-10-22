//
//  DBSDataProvider.swift
//  MykiLite
//
//  Created by Ali Fakih on 10/22/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation

public protocol DBSDataProvider: NSObject {
    func execute(_ request: URLRequest, completionHandler: ((URLResponse?, Data?, Error?) -> Void)?)
}
