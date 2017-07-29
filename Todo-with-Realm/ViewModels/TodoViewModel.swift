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
    func didChangeValue(_ todo: TodoViewModel.Current)
}

class TodoViewModel: NSObject {

    struct Current {
        var task: String = ""
        var detail: String = ""
        var due: Date?
    }

    var source = Current()

    fileprivate var todoItems = [TodoViewModelItem]()

    var reloadSections: ((_ section: Int) -> Void)? = nil

    var delegate: TodoViewModelDelegate?

    override init() {}

    convenience init(task: String, detail: String, due: Date?) {
        self.init()
        self.source.task = task
        self.source.detail = detail
        self.source.due = due

        let task = TodoViewModelTaskItem(task: task)
        todoItems.append(task)

        let detail = TodoViewModelDetailItem(detail: detail)
        todoItems.append(detail)

        var dueItem = TodoViewModelDueItem(date: Date())
        if let due = source.due {
            dueItem = TodoViewModelDueItem(date: due)
        }
        todoItems.append(dueItem)
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
            if let cell = tableView.dequeueReusableCell(with: DueCell.self, for: indexPath), let item = item as? TodoViewModelDueItem {
                cell.item = item
                cell.picker.date = item.dueDate
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let item = todoItems[section]
        switch item.type {
        case .task:
            if let header = tableView.dequeueReusableHeaderFooterView(with: TodoHeaderTaskView.self, for: section) {
                let item = todoItems[section]
                header.item = item
                header.section = section
                header.delegate = self
                header.textField.delegate = header
                return header
            }
            break
        case .detail:
            if let header = tableView.dequeueReusableHeaderFooterView(with: TodoHeaderDetailView.self, for: section) {
                let item = todoItems[section]
                header.item = item
                header.section = section
                header.delegate = self
                header.textField.delegate = header
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

}

extension TodoViewModel: TodoHeaderTaskViewDelegate {

    func changeTask( _ text: String) {
        print("got message \(String(describing: text))")
        if let section = section(Of: .task), let item = todoItems[section] as? TodoViewModelTaskItem {
            source.task = text
            item.task = text
            delegate?.didChangeValue(source)
        }
    }

}

extension TodoViewModel: TodoHeaderDetailViewDelegate {

    func changeDetail( _ text: String) {
        print("got message \(String(describing: text))")
        if let section = section(Of: .detail), let item = todoItems[section] as? TodoViewModelDetailItem {
            source.detail = text
            item.detail = text
            delegate?.didChangeValue(source)
        }
    }

}

extension TodoViewModel: TodoHeaderDueViewDelegate {

    func toggleSection(header: TodoHeaderDueView, section: Int) {
        var item = todoItems[section]
        if item.isCollapsible {
            let isCollapsed = !item.isCollapsed
            item.isCollapsed = isCollapsed
            header.setCollapsed(collopsed: isCollapsed)

            todoItems[section] = item
            reloadSections?(section)
        }
    }

}

extension TodoViewModel: DueCellDelegate {

    func shouldPost(_ date: Date?, section: Int) {
    }

    func changeValue( _ date: Date) {
        if let section = section(Of: .due), let item = todoItems[section] as? TodoViewModelDueItem {
            source.due = date
            item.dueDate = date
            delegate?.didChangeValue(source)
            reloadSections?(section)
        }
    }

    fileprivate func section(Of itemType: TodoViewModelItemType) -> Int? {
        for item in todoItems.enumerated() {
            if item.element.type == itemType {
                return item.offset
            }
        }
        return nil
    }

}












