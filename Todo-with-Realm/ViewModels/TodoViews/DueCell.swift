//
//  DueCell.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/25.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

protocol DueCellDelegate {
    func shouldPost(_ date: Date?, section: Int)
    func changeValue( _ date: Date)
}

class DueCell: UITableViewCell {

    @IBOutlet weak var picker: UIDatePicker!

    var item: TodoViewModelItem?

    var delegate: DueCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        picker.addTarget(self, action: #selector(didSelectDate), for: .valueChanged)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func didSelectDate(_ sender: UIDatePicker?) {
        guard let date = sender?.date else { return }
        delegate?.changeValue(date)
    }

}

extension DueCell: CellIdentifiable { }
