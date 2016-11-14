//
//  StringFilter.swift
//  StringFilter
//
//  Created by Tatsuya Tobioka on 1/17/16.
//  Copyright © 2016 Tatsuya Tobioka. All rights reserved.
//

import Foundation

public protocol StringFilterType {
    func transform(_ string: String) -> String
}

public enum StringFilter {
    case empty
    case capitalize, lowercase, uppercase
    case shift(Int)
    case `repeat`(Int)
    case replace(String, String)
    case multiply(StringFilterType, StringFilterType)
    case japanese(JapaneseString, JapaneseString)
}

extension String {
    var isPrintable: Bool {
        return isMatch("\\p{print}")
    }
    
    func isMatch(_ pattern: String) -> Bool {
        return range(of: pattern, options: .regularExpression) != nil
    }
}

extension UnicodeScalar {
    func shift(_ by: Int) -> String {
        let scalar = UnicodeScalar(Int(value) + by) ?? self
        return String(describing: scalar)
    }
}

extension StringFilter: StringFilterType {
    public func transform(_ string: String) -> String {
        switch self {
        case .empty:
            return string
        case .capitalize:
            return string.capitalized
        case .lowercase:
            return string.lowercased()
        case .uppercase:
            return string.uppercased()
        case .shift(let by):
            return string.unicodeScalars.reduce("") {
                let shifted = $1.shift(by)
                return $0 + (shifted.isPrintable ? shifted : String($1))
            }
        case .repeat(let count):
            return Array(repeating: string, count: count).joined(separator: "")
        case let .replace(target, replacement):
            return string.replacingOccurrences(
                of: target,
                with: replacement,
                options: [.regularExpression]
            )
        case let .multiply(left, right):
            return right.transform(left.transform(string))
        case let .japanese(from, to):
            return string.str_filter(JapaneseFilter(from: from, to: to))
        }
    }
}

public extension String {
    func str_filter(_ filter: StringFilter) -> String {
        return str_filter(filter as StringFilterType)
    }
    
    func str_filter(_ filters: [StringFilter]) -> String {
        return str_filter(filters.map { $0 as StringFilterType })
    }
    
    func str_filter(_ filter: StringFilterType) -> String {
        return filter.transform(self)
    }
    
    func str_filter(_ filters: [StringFilterType]) -> String {
        let filter = filters.reduce(StringFilter.empty, *)
        return str_filter(filter)
    }
}

public func *(lhs: StringFilterType, rhs: StringFilterType) -> StringFilterType {
    return StringFilter.multiply(lhs, rhs)
}

public func *(lhs: StringFilterType, rhs: Int) -> StringFilterType {
    switch rhs {
    case Int.min...0:
        return StringFilter.empty
    case 1:
        return lhs
    default:
        return StringFilter.multiply(lhs, (lhs * (rhs - 1)))
    }
}

public func *(lhs: Int, rhs: StringFilterType) -> StringFilterType {
    return rhs * lhs
}
