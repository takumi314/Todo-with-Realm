//
//  TodoCell.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/19.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var task: UILabel!
    // MARK: - IBOutlets

    static var identifier: String {
        return String(describing: self)
    }

    func setTodo(_ todo: Todo) {
        self.task?.text = todo.task
    }

}
