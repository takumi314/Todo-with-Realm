//
//  TodoCell.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/19.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet weak var task: UILabel!

    // MARK: - Override methods

    override var reuseIdentifier: String {
        get {
            return identifier()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }

}

extension TodoCell {

    func setTodo(_ todo: Todo) {
        self.task.text = todo.task
    }

    fileprivate func identifier() -> String {
        return self.description
    }

}
