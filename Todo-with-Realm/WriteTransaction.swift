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

    public func add<T: Persistable>(_ value: T, update: Bool = true) {
        realm.add(value.managedObject(), update: update)
    }

}
