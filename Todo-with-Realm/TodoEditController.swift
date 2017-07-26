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

    fileprivate var viewModel: TodoViewModel? = nil

    // MARK: - Initializer


    // MARK; - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TodoViewModel(todo)

        viewModel?.reloadSections = { [weak self] section in
            self?.editTableView.beginUpdates()
            self?.editTableView.reloadSections([section], with: .fade)
            self?.editTableView.endUpdates()
        }
        viewModel?.todo = todo
        viewModel?.delegate = self
        setUpTable()
    }

    func setTopbar() {
    }

    func setUpTable() {
        editTableView?.estimatedRowHeight = 100
        editTableView?.rowHeight = UITableViewAutomaticDimension
        editTableView?.sectionHeaderHeight = 70
        editTableView?.separatorStyle = .none

        editTableView?.dataSource = viewModel
        editTableView?.delegate = viewModel

        editTableView?.register(TodoHeaderTaskView.nib, forHeaderFooterViewReuseIdentifier: TodoHeaderTaskView.identifer)
        editTableView?.register(TodoHeaderDetailView.nib, forHeaderFooterViewReuseIdentifier: TodoHeaderDetailView.identifer)
        editTableView?.register(TodoHeaderDueView.nib, forHeaderFooterViewReuseIdentifier: TodoHeaderDueView.identifer)
        editTableView?.register(DueCell.nib, forCellReuseIdentifier: DueCell.identifier)

    }

    func update() {
        if editTableView?.delegate != nil, editTableView?.dataSource != nil {
            editTableView?.dataSource = nil
            editTableView?.delegate = nil
        }
        editTableView?.dataSource = viewModel
        editTableView?.delegate = viewModel
        editTableView?.reloadData()
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

// MARK: - TodoViewModelDelegate

extension TodoEditController: TodoViewModelDelegate {
    func didChangeValue(_ todo: Todo) {
        print("call didChangeValue \(todo)")
        self.todo = todo
        update()
    }
}
