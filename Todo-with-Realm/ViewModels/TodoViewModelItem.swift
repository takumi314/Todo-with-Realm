//
//  TodoViewModelItem.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/24.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation

protocol TodoViewModelItem {
    var type: TodoViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
    var isCollapsible: Bool { get }
    var isCollapsed: Bool { get set }
}

extension TodoViewModelItem {
    var rowCount: Int {
        get {
            return 1
        }
    }
    var isCollapsible: Bool {
        get {
            return true
        }
    }

}

extension TodoViewModelItem {

}
