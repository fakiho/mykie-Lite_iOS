//
//  SaveHelper.swift
//  MykiLite
//
//  Created by Ali Fakih on 10/23/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation
import UIKit

public enum StorageType {
    case userDefaults
    case fileSystem
}

public class SaveHelper: SaveHelperProtocol {
    func store(image: UIImage, forKey key: String, withStorageType storageType: StorageType) {
        if let pngRepresentation = image.pngData() {
            switch storageType {
                case .fileSystem:
                    if let filePath = filePath(forKey: key) {
                        do  {
                            try pngRepresentation.write(to: filePath,
                                                options: .atomic)
                            
                        } catch let err {
                            print("Saving file resulted in error: ", err)
                        }
                    }
                    break
                case .userDefaults:
                    UserDefaults.standard.set(pngRepresentation, forKey: key)
                    break
            }
        }
    }
    
    func retrieveImage(forKey key: String, inStorage storageType: StorageType) -> UIImage? {
        switch storageType {
        case .fileSystem:
            if let filePath = self.filePath(forKey: key),
                let fileData = FileManager.default.contents(atPath: filePath.path),
                let image = UIImage(data: fileData) {
                return image
            }
        case .userDefaults:
            if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
                let image = UIImage(data: imageData) {
                
                return image
            }
            break
        }
        return nil
    }
    
    func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        return documentURL.appendingPathComponent(key + ".png")
    }
}
