//
//  Location.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/31.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation
import RealmSwift

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

    enum PropertyValue: PropertyValueType {
        case id(Int)
        case address(String)
        case longitude(Float)
        case latitude(Float)
        case created(Date)
        case updated(Date)
        case title(String)
        case memo(String)

        var propertyValuePair: PropertyValuePair {
            switch self {
            case .id(let id):
                return ("id", id)
            case .address(let address):
                return ("address", address)
            case .longitude(let lon):
                return ("longitude", lon)
            case .latitude(let lat):
                return ("latitude", lat)
            case .created(let created):
                return ("created", created)
            case .updated(let updated):
                return ("updated", updated)
            case .title(let title):
                return ("title", title)
            case .memo(let memo):
                return ("memo", memo)
            }
        }
    }
}

