//
//  TodoViewModel.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/24.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation
import UIKit

enum TodoViewModelItemType {
    case task
    case detail
    case status
    case due
}

class TodoViewModel: NSObject {

    var todo: Todo

    var todoItems = [TodoViewModelItem]()

    var reloadSections: ((_ section: Int) -> Void)? = nil

    override init() {
        self.todo = Todo()
    }

    convenience init(_ todo: Todo) {
        self.init()
        self.todo = todo

        let item = TodoViewModelTaskItem(task: todo.task)
        todoItems.append(item)
    }

}

// MARK: - UITableViewDataSource

extension TodoViewModel: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let item = todoItems[section]
        guard item.isCollapsible else {
            return item.rowCount
        }
        if item.isCollapsed {
            return 0
        } else {
            return item.rowCount
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return todoItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = todoItems[indexPath.section]
        switch item.type {
        case .task:
            if let cell = tableView.dequeueReusableCell(with: TaskCell.self, for: indexPath) {
                cell.item = item
                return cell
            }
        case .detail:
            break
        case .status:
            break
        case .due:
            break
        }
        return UITableViewCell()
    }

}

// MARK: - UITableViewDelegate

extension TodoViewModel: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

}

