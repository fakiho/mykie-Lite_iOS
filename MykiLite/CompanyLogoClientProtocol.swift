//
//  CompanyLogoClientProtocol.swift
//  MykiLite
//
//  Created by Ali Fakih on 10/22/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation
import UIKit
public protocol CompanyLogoClientProtocol: AnyObject {
    func getLogo(domain: String, completion: @escaping(UIImage?, Error?) -> Void)
}
