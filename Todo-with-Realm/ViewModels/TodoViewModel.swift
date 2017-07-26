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

protocol TodoViewModelDelegate {
    func didChangeValue(_ todo: Todo)
}

class TodoViewModel: NSObject {

    struct input {
        var task: String = ""
        var detail: String = ""
        var due: Date
    }

    var todo: Todo

    var todoItems = [TodoViewModelItem]()

    var reloadSections: ((_ section: Int) -> Void)? = nil

    var delegate: TodoViewModelDelegate?

    override init() {
        self.todo = Todo()
    }

    convenience init(_ todo: Todo) {
        self.init()
        self.todo = todo

        let task = TodoViewModelTaskItem(task: todo.task)
        todoItems.append(task)

        let detal = TodoViewModelDetailItem(detail: todo.detail)
        todoItems.append(detal)

        if let due = todo.due {
            let dueItem = TodoViewModelDueItem(date: due)
            todoItems.append(dueItem)
        }
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
            break
        case .detail:
            break
        case .status:
            break
        case .due:
            if let cell = tableView.dequeueReusableCell(with: DueCell.self, for: indexPath) {
                cell.item = item
                cell.delegate = self
                return cell
            }
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
        let item = todoItems[section]
        switch item.type {
        case .task:
            if let header = tableView.dequeueReusableHeaderFooterView(with: TodoHeaderTaskView.self, for: section) {
                let item = todoItems[section]

                header.item = item
                header.section = section
                header.delegate = self
                header.textField.delegate = self

                return header
            }
            break
        case .detail:
            if let header = tableView.dequeueReusableHeaderFooterView(with: TodoHeaderDetailView.self, for: section) {
                let item = todoItems[section]

                header.item = item
                header.section = section
                header.delegate = self
                header.textField.delegate = self

                return header
            }
            break
        case .due:
            if let header = tableView.dequeueReusableHeaderFooterView(with: TodoHeaderDueView.self, for: section) {
                let item = todoItems[section]

                header.item = item
                header.section = section
                header.delegate = self

                return header
            }
        default:
            break
        }
        return UIView()
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let item = todoItems[section]
        switch item.type {
        case .task:
            break
        case .due:
            break
        default:
            break
        }
        return UIView()
    }

}

extension TodoViewModel: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            print(text)
            delegate?.didChangeValue(todo)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension TodoViewModel: TodoHeaderTaskViewDelegate {}

extension TodoViewModel: TodoHeaderDueViewDelegate {

    func toggleSection(header: TodoHeaderDueView, section: Int) {
        var item = todoItems[section]
        if item.isCollapsible {

            // Toggle collapse
            let collapsed = !item.isCollapsed
            item.isCollapsed = collapsed
            header.setCollapsed(collopsed: collapsed)

            // items is of struct
            todoItems[section] = item

            // Adjust the number of the rows inside the section
            reloadSections?(section)
        }
    }

}

extension TodoViewModel: DueCellDelegate {

    func shouldPost(_ date: Date?) {
        print("got message \(String(describing: date))")
    }
}

