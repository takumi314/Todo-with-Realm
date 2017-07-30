//
//  TodoHeaderDueView.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/27.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

protocol TodoHeaderDueViewDelegate {
    func toggleSection(header: TodoHeaderDueView, section: Int)
}

class TodoHeaderDueView: UITableViewHeaderFooterView {

    @IBOutlet private weak var dueLabel: UILabel!

    var item: TodoViewModelItem? {
        didSet {
            guard let item = item else {
                return
            }
            dueLabel.text = item.sectionTitle
            setCollapsed(collopsed: true)
        }
    }

    var section: Int = 2

    var delegate: TodoHeaderDueViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }

}

extension TodoHeaderDueView: HeaderFooterIdentifiable {}

extension TodoHeaderDueView: TableHViewHeaderTouchable {

    func didTapHeader() {
        delegate?.toggleSection(header: self, section: section)
    }

    func setCollapsed(collopsed: Bool) {
    }

}
