//
//  TodoHeaderDetailView.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/27.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

protocol TodoHeaderDetailViewDelegate {
    func changeDetail( _ text: String)
}

class TodoHeaderDetailView: UITableViewHeaderFooterView {

    @IBOutlet weak var textField: UITextField!

    var item: TodoViewModelItem? {
        didSet {
            guard let item = item else { return }
            textField.text = item.sectionTitle
        }
    }

    var section: Int = 1

    var delegate: TodoHeaderDetailViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension TodoHeaderDetailView: HeaderFooterIdentifiable {}

extension TodoHeaderDetailView: TableViewHeaderTouchable {}

extension TodoHeaderDetailView: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            print(text)
            delegate?.changeDetail(text)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
}
