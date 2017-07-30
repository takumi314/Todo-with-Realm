//
//  TodoListController.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/19.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

final class TodoListController: UIViewController {

    // MSRK: - Outlets
    @IBOutlet weak fileprivate var listTable: UITableView!
    @IBOutlet weak fileprivate var addingButtonItem: UIBarButtonItem!


    // MARK: - Private properties

    fileprivate var inputDate = UIDatePicker()

    fileprivate var todos = [Todo]()
    fileprivate var source: [Todo] {
        return TodoRepository.current().oldest
    }

    fileprivate struct Const {
        static let todoList = Const()

        let title = "Todo List"
        let alertTitle = "New task"
        let message = "Please fill in and tap OK, or Cancel."
        let ok = "Register"
        let cancel = "Quit"
        let task = "task"
        let detail = "detail"
        let date = "due date"
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        print(TodoRepository.realm.configuration.fileURL ?? "Fail to open")

        fetchAll()
        listTable?.delegate = self
        listTable?.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        listTable.reloadData()
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = Const.todoList.title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - IBActions

    @IBAction func didTapAddingItem(_ sender: UIBarButtonItem) {
        print("did tap buttonItem")
        didOpenForm()
    }

    func didOpenForm() {
        let alert = TodoInputController(title: Const.todoList.alertTitle,
                                        message: Const.todoList.message,
                                        preferredStyle: .alert)
        alert.delegate = self
        alert.add(.ok(Const.todoList.ok)) { [weak self] action in
            self?.textFieldHandler(alert)
            self?.reload()
        }
        alert.add(.cancel(Const.todoList.cancel), handler: nil)
        alert.add(.text(Const.todoList.task), tag: 0, handler: nil)
        alert.add(.text(Const.todoList.detail), tag: 1, handler: nil)
        alert.add(.date(Const.todoList.date), tag: 2, handler: nil)

        present(alert, animated: true, completion:nil)
    }

    private func textFieldHandler(_ alert: TodoInputController) {
        let todo = Todo()
        alert.textFields?.forEach {
            switch $0.tag {
            case 0:
                todo.task = $0.text!
                break
            case 1:
                todo.detail = $0.text!
                break
            case 2:
                if let text = $0.text, !text.isEmpty {
                    todo.due = inputDate.date
                }
                break
            default:
                break
            }
        }
        if TodoRepository.add(todo) {
            print("Add new todo.")
        }
    }

    // MSRK: - TodoRepository

    func fetchAll() {
        print("Succeed fetching \(TodoRepository.current().oldest)")
        self.todos = TodoRepository.current().oldest
    }

    func canDeleteTodo(at index: Int) -> Bool {
        let todo = todos[index]
        if TodoRepository.delete(todo) {
            fetchAll()
            return true
        }
        return false
    }

    func update() {
        if listTable?.delegate != nil, listTable?.dataSource != nil {
            listTable?.dataSource = nil
            listTable?.delegate = nil
        }
        listTable?.dataSource = self
        listTable?.delegate = self
    }

    func reload()  {
        fetchAll()
        update()
        listTable?.reloadData()
    }

    func didSelectCell(at index: Int) {
        let todoDetailVC  = TodoDetailController.instantiate()
        todoDetailVC.todo = todos[index]

        guard let navi = navigationController else {
            return print("cannot use navigate")
        }
        navi.pushViewController(todoDetailVC, animated: true)
    }

}

// MARK: - Storyboardable

extension TodoListController: Storyboardable {}

// MARK: - UITableViewDataSource

extension TodoListController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(with: TodoCell.self, for: indexPath) {
            cell.setTodo(todos[indexPath.row])
            return cell
        }
        return TodoCell()
    }
}

// MARK: - UITableViewDelegate

extension TodoListController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { return true }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listTable?.beginUpdates()
            if canDeleteTodo(at: indexPath.row) {
                listTable?.deleteRows(at: [indexPath], with: .fade)
            }
            listTable?.endUpdates()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCell(at: indexPath.row)
    }

}

// MARK: - TodoInputDelegate

extension TodoListController: TodoInputDelegate {

    func shouldMoveData(_ datePicler: UIDatePicker?) {
        print("from TodoInputController")
        guard let picker = datePicler else {
            return
        }
        inputDate = picker
    }

}
