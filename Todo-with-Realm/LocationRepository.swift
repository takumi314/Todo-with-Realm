//
//  LocationRepository.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/31.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation

struct LocationRepository {

    static func count() throws -> Int {
        return try Container()
            .values(Location.self)
            .count
    }

    static func findAll() throws -> [Location] {
        return try Container()
            .values(Location.self)
            .valus()
    }

    static func find(at id: Int) throws -> Location? {
        return try Container()
            .values(Location.self)
            .value(at: id)
    }

    static func add(_ location: Location) throws {
        try Container().write { transaction in
            transaction.add(location, update: false)
        }
    }

    static func update(_ location: Location) throws {
        try Container().write { transaction in
            transaction.add(location, update: true)

        }
    }

    static func delete(_ location: Location) throws {
        try Container().write { transaction in
            transaction.delete(location)
        }
    }

    static func deleteAll() throws {
        try Container().write { transaction in
            transaction.deleteAll()
        }
    }

    func update(with values: [Location.PropertyValue]) throws {
        try Container().write { transaction in
            transaction.update(Location.self, values: values)
        }
    }

}
