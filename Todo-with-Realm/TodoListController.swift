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
    @IBOutlet weak var listTopBar: UINavigationBar!
    @IBOutlet weak var listTable: UITableView!
    @IBOutlet weak var addingButtonItem: UIBarButtonItem!


    // MARK: - Private properties

    fileprivate var source: [Todo] {
        return TodoRepository.current
    }

    fileprivate struct Const {
        static let main = Const()
        let title = "Todo List"
        let alertTitle = "New task"
        let message = "Please fill in and tap OK, or Cancel."
        let ok = "OK"
        let cancel = "Cancel"
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listTopBar.topItem?.title = Const.main.title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - IBActions

    @IBAction func didTapButton(_ sender: UIButton) {
        print("did tap button")
        didOpenForm()
    }

    @IBAction func didTapAddingItem(_ sender: UIBarButtonItem) {
        print("did tap buttonItem")
        didOpenForm()
    }

    func didOpenForm() {
        let controller = UIAlertController(title: Const.main.alertTitle,
                                           message: Const.main.message,
                                           preferredStyle: .alert)
        let ok = UIAlertAction(title: Const.main.ok,
                               style: .default,
                               handler: nil)
        let cancel = UIAlertAction(title: Const.main.cancel,
                                   style: .cancel,
                                   handler: nil)

        controller.addAction(ok)
        controller.addAction(cancel)
        present(controller, animated: true, completion: nil)
    }
    

}

extension TodoListController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoCell = TodoCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: todoCell.reuseIdentifier) as? TodoCell {
            cell.setTodo(source[indexPath.row])
            return cell
        }
        todoCell.setTodo(source[indexPath.row])
        return todoCell
    }
}

extension TodoListController: UITableViewDelegate {

}
