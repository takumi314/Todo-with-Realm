//
//  TodoEditController.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/24.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

final class TodoEditController: UIViewController {

    @IBOutlet weak var editTableView: UITableView!
    

    var todo = Todo()

    fileprivate let viewModel = TodoViewModel()

    // MARK: - Initializer


    // MARK; - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.reloadSections = { [weak self] section in
            self?.editTableView.beginUpdates()
            self?.editTableView.reloadSections([section], with: .fade)
            self?.editTableView.endUpdates()
        }
        setTopbar()
    }

    func setTopbar() {
    }

    func setUpTable() {

    }

    fileprivate func back() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func didTapSave(_ sender: UIBarButtonItem) {
        back()
    }
    @IBAction func didTapCancel(_ sender: UIBarButtonItem) {
        back()
    }

}

// MARK: - Storyboardable

extension TodoEditController: Storyboardable {}
