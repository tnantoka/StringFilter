//
//  StringFilter.swift
//  StringFilter
//
//  Created by Tatsuya Tobioka on 1/17/16.
//  Copyright © 2016 Tatsuya Tobioka. All rights reserved.
//

import Foundation

public protocol StringFilterType {
    func transform(string: String) -> String
}

public enum StringFilter {
    case Empty
    case Capitalize, Lowercase, Uppercase
    case Shift(Int)
    case Repeat(Int)
    case Replace(String, String)
    case Multiply(StringFilterType, StringFilterType)
    case Japanese(JapaneseString, JapaneseString)
}

extension String {
    var isPrintable: Bool {
        return isMatch("\\p{print}")
    }
    
    func isMatch(pattern: String) -> Bool {
        return rangeOfString(pattern, options: .RegularExpressionSearch) != nil
    }
}

extension UnicodeScalar {
    func shift(by: Int) -> String {
        return String(UnicodeScalar(Int(value) + by))
    }
}

extension StringFilter: StringFilterType {
    public func transform(string: String) -> String {
        switch self {
        case .Empty:
            return string
        case .Capitalize:
            return string.capitalizedString
        case .Lowercase:
            return string.lowercaseString
        case .Uppercase:
            return string.uppercaseString
        case .Shift(let by):
            return string.unicodeScalars.reduce("") {
                let shifted = $1.shift(by)
                return $0 + (shifted.isPrintable ? shifted : String($1))
            }
        case .Repeat(let count):
            return Array(count: count, repeatedValue: string).joinWithSeparator("")
        case let .Replace(target, replacement):
            return string.stringByReplacingOccurrencesOfString(
                target,
                withString: replacement,
                options: [.RegularExpressionSearch]
            )
        case let .Multiply(left, right):
            return right.transform(left.transform(string))
        case let .Japanese(from, to):
            return string.str_filter(JapaneseFilter(from: from, to: to))
        }
    }
}

public extension String {
    func str_filter(filter: StringFilter) -> String {
        return str_filter(filter as StringFilterType)
    }
    
    func str_filter(filters: [StringFilter]) -> String {
        return str_filter(filters.map { $0 as StringFilterType })
    }
    
    func str_filter(filter: StringFilterType) -> String {
        return filter.transform(self)
    }
    
    func str_filter(filters: [StringFilterType]) -> String {
        let filter = filters.reduce(StringFilter.Empty, combine: *)
        return str_filter(filter)
    }
}

public func *(lhs: StringFilterType, rhs: StringFilterType) -> StringFilterType {
    return StringFilter.Multiply(lhs, rhs)
}

public func *(lhs: StringFilterType, rhs: Int) -> StringFilterType {
    switch rhs {
    case Int.min...0:
        return StringFilter.Empty
    case 1:
        return lhs
    default:
        return StringFilter.Multiply(lhs, (lhs * (rhs - 1)))
    }
}

public func *(lhs: Int, rhs: StringFilterType) -> StringFilterType {
    return rhs * lhs
}
