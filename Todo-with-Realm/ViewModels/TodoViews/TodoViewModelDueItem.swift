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
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd hh:mm"
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale.autoupdatingCurrent

        var due = "No Due yet"
        if let date = dueDate {
            due = formatter.string(from: date)
        }
        return due
    }

    var isCollapsed = true

    var dueDate: Date?

    init(date: Date?) {
        self.dueDate = date
    }
    
}
