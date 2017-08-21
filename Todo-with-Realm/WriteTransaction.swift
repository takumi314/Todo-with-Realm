//
//  WriteTransaction.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/31.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation
import RealmSwift

final class WriteTransaction {

    private let realm: Realm

    init(realm: Realm) {
        self.realm = realm
    }

    // Struct でトランジションを実行する

    public func add<T: Persistable>(_ value: T, update: Bool = true) {
        realm.add(value.managedObject(), update: update)
    }

    public func delete<T: Persistable>(_ value: T) {
        realm.delete(value.managedObject())
    }

    public func deleteAll() {
        realm.deleteAll()
    }

    public func update<T: Persistable>(_ type: T.Type, values: [T.PropertyValue]) {
        var dictionary = [String: Any]()
        values.forEach {
            let pair = $0.propertyValuePair
            dictionary[pair.name] = pair.value
        }
        realm.create(T.ManagedObject.self, value: dictionary, update: true)
    }
}
