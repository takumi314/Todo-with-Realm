//
//  DateFormatterExtension.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/07/23.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation

extension DateFormatter {

    func defaultString(from date: Date?,in zone: TimeZone = TimeZone.autoupdatingCurrent,with locale: Locale = Locale.autoupdatingCurrent) -> String {
        guard let date = date  else {
            return ""
        }
        self.dateFormat = "yyyy/MM/dd hh:mm"
        self.timeZone = zone
        self.timeStyle = .short
        self.dateStyle = .medium
        self.locale = locale
        return string(from: date)
    }

}
