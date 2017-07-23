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

    @IBOutlet weak var taskCell: UITableViewCell!
    @IBOutlet weak var detailCell: UITableViewCell!
    @IBOutlet weak var status: UITableViewCell!
    @IBOutlet weak var dueCell: UITableViewCell!
    @IBOutlet weak var created: UITableViewCell!

    // MARK: - public properties

    var todos = [Todo]()
    var todo: Todo? = nil

    // MARK:- Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let todo = self.todo else {
            return
        }
        setValue(todo)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Content"
    }

    // MARK: - Private methods

    private func setValue(_ todo: Todo) {
        self.taskCell.textLabel?.text = todo.task
        self.detailCell.textLabel?.text = todo.detail
        self.status.textLabel?.text = todo.isComplete ? "Done" : "Not completed"
        self.dueCell.textLabel?.text = todo.due?.description
        self.created.textLabel?.text = todo.created.description
    }

    func updateData(_ todo: Todo) {
        if TodoRepository.update(todo) {
            let keyId = todo.id.description
            setValue(TodoRepository.find(keyId)!)
        }
    }

}



extension TodoDetailController: Storyboardable { }
