//
//  TaskCell.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/25.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {


    @IBOutlet weak var textField: UITextField!

    var item: TodoViewModelItem? {
        didSet {
            guard  let item = item as? TodoViewModelTaskItem else {
                return
            }
            textField.text = item.task
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

}

extension TaskCell: CellIdentifiable {

}

