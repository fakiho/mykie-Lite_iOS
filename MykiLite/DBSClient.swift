//
//  DBSClient.swift
//  MykiLite
//
//  Created by Ali Fakih on 10/22/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation

public protocol DBSClient: NSObject {
    var dataProvider: DBSDataProvider? { get }
    var baseURL: URL { get }
}
