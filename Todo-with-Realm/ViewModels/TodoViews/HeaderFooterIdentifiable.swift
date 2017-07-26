//
//  HeaderFooterIdentifiable.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/26.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit


protocol HeaderFooterIdentifiable: Nibable {
    // override
}

extension HeaderFooterIdentifiable {

    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }

    static var nibName: String {
        return String(describing: className)
    }

    static var identifier: String {
        return String(describing: className)
    }
    
}
