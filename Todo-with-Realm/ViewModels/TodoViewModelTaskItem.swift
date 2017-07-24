//
//  TodoViewModelTaskItem.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/25.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation

class TodoViewModelTaskItem: TodoViewModelItem {

    var type: TodoViewModelItemType {
        return .task
    }

    var isCollapsible: Bool {
        return true
    }

    var sectionTitle: String {
        return "Task"
    }

    var isCollapsed = false

    var task: String

    init(task: String) {
        self.task = task
    }

}
