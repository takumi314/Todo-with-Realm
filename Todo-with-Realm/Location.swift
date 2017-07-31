//
//  Location.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/31.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation
import RealmSwift

class Location: Object {
    dynamic var id = 0
    dynamic var address: String = ""
    dynamic var longitude: Float = 0
    dynamic var latitude: Float = 0
    dynamic var created: Date = Date()
    dynamic var updated: Date?
    dynamic var title: String?
    dynamic var memo: String?

    override class func primaryKey() -> String? {
        return "id"
    }

}
