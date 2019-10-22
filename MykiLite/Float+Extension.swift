//
//  Float+Extension.swift
//  MykiLite
//
//  Created by Ali Fakih on 10/22/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGFloat {
    public static func grid(_ number: CGFloat) -> CGFloat {
        return number * 8.0
    }

    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
