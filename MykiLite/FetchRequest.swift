//
//  FetchRequest.swift
//  MykiLite
//
//  Created by Awwad on 8/14/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation
import RealmSwift

struct FetchRequest<Model, RealmObject: Object> {
    let predicate: NSPredicate?
    let sortDescriptors: [SortDescriptor]
    let transformer: (Results<RealmObject>) -> Model
}

extension SortDescriptor {
    static let nickname = SortDescriptor(keyPath: "nickname", ascending: true)
}

extension Password {
    static let all = FetchRequest<[Password], PasswordObject>(predicate: nil, sortDescriptors: [], transformer: { $0.map(Password.init) })
}
