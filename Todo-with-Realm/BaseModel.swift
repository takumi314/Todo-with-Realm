//
//  BaseModel.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/18.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation
import RealmSwift

protocol BaseModel {
}

protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    init(_ managedObject: ManagedObject)
    func managedObject() -> ManagedObject

    associatedtype PropertyValue: PropertyValueType
}

public typealias PropertyValuePair = (name: String, value: Any)

public protocol PropertyValueType {
    var propertyValuePair: PropertyValuePair { get }
}
