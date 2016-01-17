//
//  StringFilter.swift
//  StringFilter
//
//  Created by Tatsuya Tobioka on 1/17/16.
//  Copyright © 2016 Tatsuya Tobioka. All rights reserved.
//

import Foundation

public indirect enum StringFilter {
    case Empty
    case Capitalize, Lowercase, Uppercase
    case Shift(Int)
    case Repeat(Int)
    case Replace(String, String)
    case Multiply(StringFilter, StringFilter)
}

extension String {
    var str_isPrintable: Bool {
        return rangeOfString("\\p{print}", options: [.RegularExpressionSearch]) != nil
    }
}

public extension String {
    func str_filter(filter: StringFilter) -> String {
        switch filter {
        case .Empty:
            return self
        case .Capitalize:
            return capitalizedString
        case .Lowercase:
            return lowercaseString
        case .Uppercase:
            return uppercaseString
        case .Shift(let by):
            return unicodeScalars.reduce("") {
                let shifted = String(UnicodeScalar(Int($1.value) + by))
                return $0 + (shifted.str_isPrintable ? shifted : String($1))
            }
        case .Repeat(let count):
            return Array(count: count, repeatedValue: self).joinWithSeparator("")
        case let .Replace(target, replacement):
            return stringByReplacingOccurrencesOfString(
                target,
                withString: replacement,
                options: [.RegularExpressionSearch]
            )
        case let .Multiply(left, right):
            return str_filter(left).str_filter(right)
        }
    }
    
    func str_filter(filters: [StringFilter]) -> String {
        let filter = filters.reduce(.Empty, combine: *)
        return str_filter(filter)
    }
}

public func *(lhs: StringFilter, rhs: StringFilter) -> StringFilter {
    return .Multiply(lhs, rhs)
}
