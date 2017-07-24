//
//  TodoEditController.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/24.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

class TodoEditController: UIViewController {

    @IBOutlet weak var editTableView: UITableView!

    fileprivate let viewModel = TodoViewModel()


    // MARK; - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.reloadSections = { [weak self] section in
            self?.editTableView.beginUpdates()
            self?.editTableView.reloadSections([section], with: .fade)
            self?.editTableView.endUpdates()
        }
    }

    func setUpTable() {

    }


}
