//
//  User.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/18.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object, BaseModel {
    dynamic var name: String = "Anonymous"
    dynamic var account: String = ""
    dynamic var password: String = ""
    dynamic var created: Date = Date()
}

