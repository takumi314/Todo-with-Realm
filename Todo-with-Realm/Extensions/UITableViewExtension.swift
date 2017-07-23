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

}
