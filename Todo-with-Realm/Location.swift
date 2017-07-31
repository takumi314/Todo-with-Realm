//
//  Location.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/31.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation
import RealmSwift

struct Location {
    let id: Int
    let address: String
    let longitude: Float
    let latitude: Float
    let created: Date
    let updated: Date?
    let title: String?
    let memo: String?
}


extension Location: Persistable {

    typealias ManagedObject = LocationObject

    init(_ managedObject: ManagedObject) {
        self.id         = managedObject.id
        self.address    = managedObject.address
        self.longitude  = managedObject.longitude
        self.latitude   = managedObject.latitude
        self.created    = managedObject.created
        self.updated    = managedObject.updated
        self.title      = managedObject.title
        self.memo       = managedObject.memo
    }

    func managedObject() -> LocationObject {
        let location = LocationObject()
        location.id         = id
        location.address    = address
        location.longitude  = longitude
        location.latitude   = latitude
        location.created    = created
        location.updated    = updated
        location.title      = title
        location.memo       = memo
        return location
    }
}


final class LocationObject: Object {
    dynamic var id: Int = 0
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
