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

    func add() -> Bool

    func find(_ id: Int) -> Todo?

    func findAll() -> [Todo]

    func delete(_ id: Int) -> Bool

    func deleteAll() -> Bool

    func update(_ task: String, details: String) -> Bool

}
