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

    @IBOutlet weak var ListTable: UITableView!


    // MARK: - Private properties

    var source: [Todo] {
        return TodoRepository.current
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
