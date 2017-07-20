//
//  TodoListController.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/19.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

class TodoListController: UIViewController {

    // MSRK: - Outlets
    @IBOutlet weak fileprivate var listTopBar: UINavigationBar!
    @IBOutlet weak fileprivate var listTable: UITableView!
    @IBOutlet weak fileprivate var addingButtonItem: UIBarButtonItem!


    // MARK: - Private properties

    fileprivate var todos = [Todo]()
    fileprivate var source: [Todo] {
        return TodoRepository.current().oldest
    }

    fileprivate struct Const {
        static let main = Const()
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
        super.viewWillAppear(animated)
        listTopBar.topItem?.title = Const.main.title
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
        let alert = UIAlertController(title: Const.main.alertTitle,
                                      message: Const.main.message,
                                      preferredStyle: .alert)
        let ok = UIAlertAction(title: Const.main.ok,
                               style: .default,
                               handler: { [weak self] action in
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
                                        // todo.due = Date($0.text)!
                                        break
                                    default:
                                        break
                                    }
                                }
                                if TodoRepository.add(todo) { print("Add new todo.") }
                                self?.reload()
        })
        let cancel = UIAlertAction(title: Const.main.cancel,
                                   style: .cancel,
                                   handler: nil)

        alert.addAction(ok)
        alert.addAction(cancel)
        alert.addTextField(configurationHandler: { field in
            field.tag = 0
            field.placeholder = Const.main.task

            let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 30.0))
            label.text = ""
            field.leftView = label
            field.leftViewMode = UITextFieldViewMode.always
        })

        alert.addTextField(configurationHandler: { field in
            field.tag = 1
            field.placeholder = Const.main.detail

            let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 30.0))
            label.text = ""
            field.leftView = label
            field.leftViewMode = UITextFieldViewMode.always

        })

        let doneItem = UIBarButtonItem(barButtonSystemItem: .done,
                                   target: self,
                                   action: #selector(didTapKeyboardDone) )
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                     target: self,
                                     action: #selector(didTapKeyboardCacel) )
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                         target: self,
                                         action: nil)

        let frame = CGRect(x: 0.0, y: 0.0, width: view.bounds.size.width, height: 35.0)
        let toolBar = UIToolbar(frame: frame)
        toolBar.barStyle = .blackTranslucent
        toolBar.backgroundColor = .white
        toolBar.items = [doneItem, flexibleItem, cancelItem]

        let datePicker = UIDatePicker()
        datePicker.addTarget(self, action: #selector(selectDate), for: .valueChanged)

        alert.addTextField(configurationHandler: { field in
            field.tag = 2
            field.placeholder = Const.main.date
            let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 30.0))
            label.text = ""
            field.leftView = label
            field.leftViewMode = UITextFieldViewMode.always


            field.inputView = datePicker
            field.inputAccessoryView = toolBar
        })

        present(alert, animated: true, completion: nil)
    }

    func didTapKeyboardDone() {
        print("tap done")
    }

    func didTapKeyboardCacel() {
        print("tap cancel")
    }

    func selectDate() {
        print("set Date")
    }

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

}

extension TodoListController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as? TodoCell {
            cell.setTodo(todos[indexPath.row])
            return cell
        }
        return TodoCell()
    }
}

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
}
