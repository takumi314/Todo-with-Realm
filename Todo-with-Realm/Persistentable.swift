//
//  Persistentable.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/18.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation
import RealmSwift

protocol Persistentable {

    static var realm: Realm { get }

    static func count() -> Int

    static func add<T>(_ item: T) -> Bool

    static func find<T, K>(_ id: K) -> T?

    static func findAll<ObjectType>() -> Results<ObjectType>

    static func delete<T>(_ id: T) -> Bool

    static func deleteAll() -> Bool

    static func update<T>(_ item: T) -> Bool

}

extension Persistentable {

    static var results: Results<Todo> {
        get {
            return findAll()
        }
        set {
            
        }
    }

    static var realm: Realm {
        return try! Realm()
    }

    static func count() -> Int {
        let realm = try! Realm()
        return realm.objects(Todo.self).count
    }

    static func add<T: Todo>(_ item: T) -> Bool {
        let realm = try! Realm()
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            debugPrint(error)
            return false
        }
        return true
    }

    static func find<T: Todo>(_ id: Int) -> T? {
        let realm = try! Realm()
        return realm.object(ofType: T.self, forPrimaryKey: id)
    }

    static func findAll<T: Todo>() -> Results<T> {
        let realm = try! Realm()
        return realm.objects(T.self).sorted(byKeyPath: "id", ascending: true)
    }

    static func delete<T: Todo>(_ id: T) -> Bool {
        let realm = try! Realm()
        do {
            try realm.write {
                // プライマリーキーを指定する
            }
        } catch {
            debugPrint(error)
            return false
        }
        return true
    }

    static func deleteAll() -> Bool {
        let realm = try! Realm()
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            debugPrint(error)
            return false
        }
        return true
    }

    static func update(_ item: Todo) -> Bool {
        let realm = try! Realm()
        do {
            try realm.write {
                realm.add(item, update: true)
            }
        } catch {
            debugPrint(error)
            return false
        }
        return true
    }

}






