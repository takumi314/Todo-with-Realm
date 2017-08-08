//
//  TodoViewModelDueItem.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/25.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation

class TodoViewModelDueItem: TodoViewModelItem {

    var type: TodoViewModelItemType {
        return .due
    }

    var isCollapsible: Bool {
        return true
    }

    var sectionTitle: String {
        return dueDate == nil ? "No Due yet" : DateFormatter().defaultString(from: dueDate)
    }

    var isCollapsed = true

    var dueDate: Date?

    init(date: Date?) {
        self.dueDate = date
    }
    
}
