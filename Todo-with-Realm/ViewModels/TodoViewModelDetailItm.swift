//
//  TodoViewModelDetailItm.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/27.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation

class TodoViewModelDetailItem: TodoViewModelItem {

    var type: TodoViewModelItemType {
        return .detail
    }

    var isCollapsible: Bool {
        return true
    }

    var sectionTitle: String {
        return detail
    }

    var isCollapsed = true

    var detail: String

    init(detail: String) {
        self.detail = detail
    }

}
