//
//  TodoInputController.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/24.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

protocol TodoInputDelegate {
    func shouldMoveData(_ datePicler: UIDatePicker?)
}

class TodoInputController: UIAlertController {

    // MARK: - Public properties

    var delegate: TodoInputDelegate?

    // MARK: - Private prorperties

    private var inputDate: UIDatePicker?

    // MARK: - Enum

    enum InputType {
        case ok(String)
        case cancel(String)
        case text(String)
        case date(String)
    }

    // MARK: - Public methods

    func add(_ input: InputType, tag: Int = -1, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        switch input {
        case .ok(let title):
            let ok = UIAlertAction(title: title,
                                   style: .default,
                                   handler: handler)
            self.addAction(ok)
            break
        case .cancel(let title):
            let cancel = UIAlertAction(title: title,
                                       style: .cancel,
                                       handler: handler)
            self.addAction(cancel)
            break
        case .text(let placeholder):
            self.addTextField(configurationHandler: { field in
                field.tag = tag
                field.placeholder = placeholder

                let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 30.0))
                label.text = ""
                field.leftView = label
                field.leftViewMode = UITextFieldViewMode.always
            })
            break
        case .date(let placeholder):
            self.addPickerDate(placeholder: placeholder, tag: tag) { picker in
                print(picker.date)
            }
            break
        }
    }

    func addPickerDate(placeholder: String, tag: Int, configurationHandler: ((UIDatePicker) -> Swift.Void)? = nil) {
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done,
                                       target: self,
                                       action: #selector(didTapKeyboardDone) )
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                         target: self,
                                         action: #selector(didTapKeyboardCacel) )
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                           target: self,
                                           action: nil)

        let frame = CGRect(x: 0.0, y: 0.0, width: view.bounds.size.width, height: 35.0)
        let toolBar = UIToolbar(frame: frame)
        toolBar.barStyle = .blackTranslucent
        toolBar.backgroundColor = .white
        toolBar.items = [doneItem, flexibleItem, cancelItem]

        let datePicker = UIDatePicker()
        datePicker.addTarget(self,
                             action: #selector(selectDate),
                             for: .valueChanged)

        self.addTextField(configurationHandler: { [weak self] field in
            field.tag = tag
            field.placeholder = placeholder

            let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 30.0))
            label.text = ""
            field.leftView = label
            field.leftViewMode = UITextFieldViewMode.always

            field.inputView = datePicker
            field.inputAccessoryView = toolBar

            field.delegate = self

            self?.inputDate?.date = datePicker.date
        })
    }

    // MARK: - UIDatePicker

    @objc private func didTapKeyboardDone() {
        print("tap done")
        if let field = self.textFields?[2] {
            field.resignFirstResponder()
            field.delegate = nil
        }
        delegate?.shouldMoveData(inputDate)
    }

    @objc private func didTapKeyboardCacel() {
        print("tap cancel")
        if let field = self.textFields?[2] {
            field.text = ""
            field.resignFirstResponder()
            field.delegate = nil
        }
        delegate?.shouldMoveData(nil)
    }

    @objc private func selectDate(_ sender: UIDatePicker) {
        print("set Date, \(sender.date)")
        inputDate?.date = sender.date

        if let field = self.textFields?[2], self.textFields?[2].tag == 2 {
            field.delegate = self

            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd hh:mm"
            formatter.timeZone = TimeZone.autoupdatingCurrent
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            formatter.locale = Locale.autoupdatingCurrent
            field.text = formatter.string(from: sender.date)
        }
        delegate?.shouldMoveData(sender)
    }

}

// MARK: - UITextFieldDelegate

extension UIAlertController: UITextFieldDelegate {

    public func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
}
