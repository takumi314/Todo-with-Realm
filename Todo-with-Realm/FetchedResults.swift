//
//  FetchedResults.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/31.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation
import RealmSwift

final class FetchedResults<T: Persistable> {

    internal let results: Results<T.ManagedObject>

    public var count: Int {
        return results.count
    }

    internal init(results: Results<T.ManagedObject>) {
        self.results = results
    }

    public func value(at index: Int) -> T {
        return T(results[index])
    }

    public func valus() -> [T] {
        return results.sorted(byKeyPath: "created", ascending: true).map({ T($0) })
    }

}
