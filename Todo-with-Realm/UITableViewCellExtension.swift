//
//  UITableViewCellExtension.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/23.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {

    ///
    /// カスタムUITableViewCellのクラス名と同一なidentifierを返す.
    ///
    /// Note: Only a Xib file on a custom cell class.
    ///
    static var identifer: String {
        return className
    }

}
