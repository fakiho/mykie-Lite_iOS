//
//  Database.swift
//  MykiLite
//
//  Created by Awwad on 8/14/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation
import RealmSwift

final class Database {
    
    private let realm: Realm
    
    init(realm: Realm = try! Realm()) {
        self.realm = realm
    }
    
    func createOrUpdate<Model, RealmObject: Object>(model: Model, with reverseTransformer: (Model) -> RealmObject) {
        let object = reverseTransformer(model)
        
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch (let error) {
            //error adding
            debugPrint("Realm Writing Error: \(error.localizedDescription)")
        }
    }
    
    func fetch<Model, RealmObject>(with request: FetchRequest<Model, RealmObject>) -> Model {
        var results = realm.objects(RealmObject.self)
        
        if let predicate = request.predicate {
            results = results.filter(predicate)
        }
        
        if request.sortDescriptors.count > 0 {
            results = results.sorted(by: request.sortDescriptors)
        }
        
        return request.transformer(results)
    }
    
    func delete<RealmObject: Object>(type: RealmObject.Type, with primaryKey: String) {
        let object = realm.object(ofType: type, forPrimaryKey: primaryKey)
        if let object = object {
            do {
                try realm.write {
                    realm.delete(object)
                }
            } catch (let error) {
                debugPrint("Realm Error Deleting: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteAll() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch (let error) {
            debugPrint("Realm Error Deleting: \(error.localizedDescription)")
        }
    }
    
}
