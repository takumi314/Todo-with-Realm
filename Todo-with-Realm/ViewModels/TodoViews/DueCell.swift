//
//  DueCell.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/25.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

protocol DueCellDelegate {
    func shouldPost(_ date: Date?)
}

class DueCell: UITableViewCell {

    @IBOutlet private weak var picker: UIDatePicker!

    var item: TodoViewModelItem? {
        didSet {
            guard let item = item as? TodoViewModelDueItem else {
                return
            }
            picker.date = item.dueDate
        }
    }

    var delegate: DueCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        picker.addTarget(self, action: #selector(didSelectDate), for: .valueChanged)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func didSelectDate(_ sender: UIDatePicker?) {
        guard let date = sender?.date else {
            return
        }
        delegate?.shouldPost(date)
    }

}

extension DueCell: CellIdentifiable {
    
}
