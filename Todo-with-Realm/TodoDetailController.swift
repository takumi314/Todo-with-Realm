//
//  TodoDetailController.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/23.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

final class TodoDetailController: UITableViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var taskCell: UITableViewCell!
    @IBOutlet private weak var detailCell: UITableViewCell!
    @IBOutlet private weak var status: UITableViewCell!
    @IBOutlet private weak var dueCell: UITableViewCell!
    @IBOutlet private weak var created: UITableViewCell!

    // MARK: - Public properties

    var todos = [Todo]()
    var todo: Todo? = nil

    // MARK:- Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.todos = TodoRepository.current().oldest
        tableView.reloadData()

        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Content"

        guard let todo = self.todo else {
            return
        }
        setValue(todo)
    }

    // MARK: - Private methods

    private func setValue(_ todo: Todo) {
        self.taskCell.textLabel?.text = todo.task
        self.detailCell.textLabel?.text = todo.detail
        self.status.textLabel?.text = todo.isComplete ? "Done" : "Not completed"

        var dueString = ""
        if let due = todo.due {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd hh:mm"
            formatter.timeZone = TimeZone.autoupdatingCurrent
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            formatter.locale = Locale.autoupdatingCurrent
            dueString = formatter.string(from: due)
        }
        self.dueCell.textLabel?.text = dueString

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd hh:mm"
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale.autoupdatingCurrent
        self.created.textLabel?.text = formatter.string(from: todo.created)
    }

    func updateData(_ todo: Todo) {
        if TodoRepository.update(todo) {
            let keyId = todo.id.description
            setValue(TodoRepository.find(keyId)!)
        }
    }

    fileprivate func move(_ todo: Todo) {
        let editVC = TodoEditController.instantiate()
        editVC.todo = todo
        editVC.view.backgroundColor = .cyan
        present(editVC, animated: true, completion: {
            print("get to Editing Mode")
        })
    }

}

extension TodoDetailController: Storyboardable {}

extension TodoDetailController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section)
        print(indexPath.row)
        guard let todo = self.todo else {
            return
        }
        move(todo)
    }

}






