//
//  Date+toString.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/21.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation

enum Pattern: String {
    case yyyyMMddHHmmss
    case yyyyMMdd
    case HHmm
}

public extension Date {
    internal func toString(with pattern: Pattern) -> String {
        let formatter = DateFormatter()
        switch pattern {
        case .yyyyMMddHHmmss:
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return formatter.string(from: self)
        case .yyyyMMdd:
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: self)
        case .HHmm:
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: self)
        }
    }
}
