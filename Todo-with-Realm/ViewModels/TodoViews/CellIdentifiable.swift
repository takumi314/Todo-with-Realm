//
//  CellIdentifiable.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/25.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

protocol CellIdentifiable: Nibable {
    // override
}

extension CellIdentifiable {

    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }

    static var nibName: String {
        return String(describing: className)
    }

}
