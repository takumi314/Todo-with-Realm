//
//  TodoHeaderTaskView.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/27.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

protocol TodoHeaderTaskViewDelegate {
    func changeTask( _ text: String)
}

class TodoHeaderTaskView: UITableViewHeaderFooterView {

    @IBOutlet weak var textField: UITextField!

    var item: TodoViewModelItem? {
        didSet {
            guard let item = item else { return }
            textField.text = item.sectionTitle
        }
    }

    var section: Int = 0

    var delegate: TodoHeaderTaskViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

    }

}

extension TodoHeaderTaskView: HeaderFooterIdentifiable {}

extension TodoHeaderTaskView: TableHViewHeaderTouchable {}

extension TodoHeaderTaskView: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            print(text)
            delegate?.changeTask(text)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
