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
    @IBOutlet weak var updateButton: UIBarButtonItem!

    var todo: Todo? = nil

    var viewModel = TodoViewModel()

    // MARK: - Initializer


    // MARK; - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if let v = todo {
            viewModel = TodoViewModel(task: v.task, detail: v.detail, due: v.due)
        }
        viewModel.delegate = self
        viewModel.reloadSections = { [weak self] section in
            self?.editTableView.beginUpdates()
            self?.editTableView.reloadSections([section], with: .fade)
            self?.editTableView.endUpdates()
        }
        setUpTable()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // disable to save before updating any data source.
        updateButton.isEnabled = false
    }


    // MARK: - IBActions

    @IBAction func didTapSave(_ sender: UIBarButtonItem) {
        print("\(viewModel.source)")
        guard let todo = self.todo else { return }

        // 編集データを同期開始
        let _ = isUpdated(with: todo) { [weak self] in
            self?.updateButton.isEnabled = false
            self?.back()
        }
    }

    @IBAction func didTapCancel(_ sender: UIBarButtonItem) {
        back()
    }

    // MAEK: private methods

    private func setUpTable() {
        editTableView?.estimatedRowHeight = 100
        editTableView?.rowHeight = UITableViewAutomaticDimension
        editTableView?.sectionHeaderHeight = 70
        editTableView?.separatorStyle = .none

        editTableView?.dataSource = viewModel
        editTableView?.delegate = viewModel

        editTableView?.register(TodoHeaderTaskView.nib, forHeaderFooterViewReuseIdentifier: TodoHeaderTaskView.identifer)
        editTableView?.register(TodoHeaderDetailView.nib, forHeaderFooterViewReuseIdentifier: TodoHeaderDetailView.identifer)
        editTableView?.register(TodoHeaderDueView.nib, forHeaderFooterViewReuseIdentifier: TodoHeaderDueView.identifer)
        editTableView?.register(TodoHeaderLocationView.nib, forHeaderFooterViewReuseIdentifier: TodoHeaderLocationView.identifer)
        editTableView?.register(DueCell.nib, forCellReuseIdentifier: DueCell.identifier)
        editTableView?.register(LocationCell.nib, forHeaderFooterViewReuseIdentifier: LocationCell.identifier)
    }

    fileprivate func isUpdated(with todo: Todo, completion: @escaping () -> Void )  -> Bool {
        let task = viewModel.source.task
        let detail = viewModel.source.detail
        guard let due = viewModel.source.due else { return false }
        if TodoRepository.update(due: due, for: todo),
            TodoRepository.update(task: task, for: todo),
            TodoRepository.update(detail: detail, for: todo) {
            completion()
            return true
        }
        return false
    }

    fileprivate func update() {
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

    fileprivate func synchronized() {
        let source = viewModel.source
        todo?.task = source.task
        todo?.detail = source.detail
        todo?.due = source.due

        // 編集済みのため
        if !updateButton.isEnabled {
            updateButton.isEnabled = true
        }
    }

}

// MARK: - Storyboardable

extension TodoEditController: Storyboardable {}

// MARK: - TodoViewModelDelegate

extension TodoEditController: TodoViewModelDelegate {
    func didChangeValue(_ todo: TodoViewModel.Current) {
        print("call didChangeValue \(todo)")
        updateButton.isEnabled = true
    }
}
