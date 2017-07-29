//
//  Todo.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/18.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation
import RealmSwift

class Todo: Object {
    dynamic var id: String = ""
    dynamic var task: String = ""
    dynamic var detail: String = ""
    dynamic var isComplete: Bool = false
    dynamic var due: Date?
    dynamic var created: Date = Date()
    dynamic var finished: Date?
    dynamic var deleted: Date?

    override class func primaryKey() -> String? {
        return "id"
    }
}

extension Todo {
}
