//
//  TodoViewModelLocationItem.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/08/13.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation

class TodoViewModelLocationItem: TodoViewModelItem {

    var type: TodoViewModelItemType {
        get {
            return .location
        }
    }
    var sectionTitle: String {
        get {
            guard let adress = self.address else {
                return "No address"
            }
            return adress
        }
    }
    var isCollapsed: Bool = true

    var address: String?

    init(address: String?) {
        self.address = address
    }

}

extension TodoViewModelLocationItem {

}
