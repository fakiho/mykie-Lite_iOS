//
//  File.swift
//  MykiLite
//
//  Created by Ali Fakih on 10/23/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation
import UIKit

protocol SaveHelperProtocol: AnyObject {
    func store(image: UIImage, forKey key: String, withStorageType storageType: StorageType)
    func retrieveImage(forKey key: String, inStorage storageType: StorageType) -> UIImage?
    func filePath(forKey key: String) -> URL?
}
