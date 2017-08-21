//
//  UITableViewHeaderFooterView.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/26.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

extension UITableViewHeaderFooterView {

    ///
    /// カスタムUITableViewCellのクラス名と同一なidentifierを返す.
    ///
    /// Note: Only a Xib file on a custom cell class.
    ///
    static var identifer: String {
        return className
    }
    
}

protocol TableViewHeaderTouchable {
    var section: Int { get }
    func didTapHeader()
    func setCollapsed(collopsed: Bool)
}

extension TableViewHeaderTouchable where Self: UITableViewHeaderFooterView  {

    func didTapHeader() {
    }

    func setCollapsed(collopsed: Bool) {
    }

}
