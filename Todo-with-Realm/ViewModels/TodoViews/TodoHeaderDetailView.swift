//
//  TodoHeaderDetailView.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/27.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

protocol TodoHeaderDetailViewDelegate {

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

    var delegate: TodoHeaderTaskViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension TodoHeaderDetailView: HeaderFooterIdentifiable {

}

extension TodoHeaderDetailView: TableHViewHeaderTouchable {}
