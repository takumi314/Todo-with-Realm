//
//  TodoRepository.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/18.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation
import RealmSwift

struct TodoRepository {

    static var results: Results<Todo> {
        get {
            return realm.objects(Todo.self)
        }
    }

    static var realm: Realm {
        return try! Realm()
    }

    static func count() -> Int {
        return realm.objects(Todo.self).count
    }


    static func add<T>(_ item: T) -> Bool where T: Todo {
        do {
            try realm.write {
                realm.add(item, update: false)
            }
        } catch {
            return false
        }
        return true
    }

    static func find<T: Todo>(_ id: Int) -> T? {
        return realm.object(ofType: T.self, forPrimaryKey: id)
    }

    static func findAll<T: Todo>() -> Results<T> {
        return realm.objects(T.self)
    }

    static func delete(_ id: Int) -> Bool {
        let todos = results
            .filter { $0.id == id }
            .flatMap { $0 }

        guard todos.count == 1 else {
            return false
        }

        do {
            try realm.write {
                realm.delete(todos)
            }
        } catch {
            return false
        }
        return true
    }

    static func deleteAll() -> Bool {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            return false
        }
        return true
    }

    static func update<T: Todo>(_ item: T) -> Bool {
        do {
            try realm.write {
                realm.add(item, update: true)
            }
        } catch {
            return false
        }
        return true
    }

}
