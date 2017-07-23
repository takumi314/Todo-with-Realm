//
//  NibBase.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/23.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

protocol Nibable: NSObjectProtocol {
    var nibName: String { get }
    var nib: UINib { get }
}
