//
//  StoryboardBase.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/23.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

extension NSObjectProtocol {

    ///
    /// return a class name which is confirmed with NSObjectProtocol
    ///
    static var className: String {
        return String(describing: self)
    }
}

protocol Storyboardable: NSObjectProtocol {
    static var storyboardName: String { get }
    static func instantiate() -> Self
}

extension Storyboardable where Self: UIViewController {

    static var storyboardName: String {
        return className
    }

    static func instantiate() -> Self {
        return UIStoryboard(
            name: storyboardName,
            bundle: nil
        )
        .instantiateInitialViewController() as! Self
    }

}
