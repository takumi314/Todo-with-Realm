//
//  Container.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/31.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation
import RealmSwift

final class Container {

    private let realm: Realm

    private init(realm: Realm) {
        self.realm = realm
    }

    public convenience init() throws {
        try self.init(realm: Realm())
    }

    // execute a transaction with block.
    public func write(_ block: (WriteTransaction) throws -> Void) throws {
        let transaction = WriteTransaction(realm: realm)
        do {
            try realm.write {
                try block(transaction)
            }
        } catch {
            print("failed to write")
        }
    }

    // retrive results which consists of Struct type.
    public func values<T: Persistable> (_ type: T.Type) -> FetchedResults<T> {
        let results = realm.objects(T.ManagedObject.self)
        return FetchedResults(results: results)
    }

}
