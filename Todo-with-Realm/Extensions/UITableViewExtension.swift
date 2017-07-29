//
//  UITableViewExtension.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/23.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {

    ///
    /// UITableViewに　Customcell を登録する
    ///
    /// T: Type parameter of UITTableViewCell
    ///
    func register<T: UITableViewCell>(_ cellType: T.Type) where T: Nibable {
        self.register(T.nib, forCellReuseIdentifier: T.identifer)
    }

    ///
    /// Register a custom cell by the type cell, which is the same as any class type
    ///
    func register<T: UITableViewCell>(_ cellType: T.Type) {
        self.register(T.self, forCellReuseIdentifier: T.identifer)
    }

    ///
    /// return custom cell with Type parameter T and indexPath
    ///
    func dequeueReusableCell<T: UITableViewCell>(with cellType: T.Type,for indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withIdentifier: T.identifer, for: indexPath) as? T
    }

    ///
    /// return 
    ///
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(with headerFooterType: T.Type,for section: Int) -> T? {
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.identifer) as? T
    }

}
