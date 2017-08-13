//
//  TodoHeaderLocationView.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/08/10.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit
import MapKit

protocol TodoHeaderLocationViewDelegate {
    //
}

class TodoHeaderLocationView: UITableViewHeaderFooterView {

    // MARK: - IBOutlets

    @IBOutlet weak var addressLabel: UILabel!

    // MARK: - Public properties

    var item: TodoViewModelItem? {
        didSet {
            guard let item = item else { return }
            self.addressLabel.text = item.sectionTitle
        }
    }

    var section: Int = 3

    var delegate: TodoHeaderLocationViewDelegate?

    // MARK: - Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension TodoHeaderLocationView: HeaderFooterIdentifiable {}

extension TodoHeaderLocationView: TableViewHeaderTouchable {

}
