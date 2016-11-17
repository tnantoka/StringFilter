//
//  JapaneseFilter.swift
//  StringFilter
//
//  Created by Tatsuya Tobioka on 1/18/16.
//  Copyright © 2016 Tatsuya Tobioka. All rights reserved.
//

import Foundation
import CoreFoundation

public indirect enum JapaneseString {
    case katakana
    case hiragana
    case alphabet
    case number
    case full(JapaneseString)
    case half(JapaneseString)
}

struct Distance {
    static let kana = 96
    static let alnum = 65248
}

struct JapaneseFilter {
    let from: JapaneseString
    let to: JapaneseString
}

extension String {
    func shift(_ by: Int, pattern: String) -> String {
        return unicodeScalars.reduce("") {
            let origin = String($1)
            return $0 + (origin.isMatch(pattern) ? $1.shift(by) : origin)
        }
    }
    
    func replace(_ pattern: String, replacement: @escaping (String) -> String) -> String {
#if os(Linux)
        guard let regex = try? RegularExpression(pattern: pattern, options: []) else { return self }
#else
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return self }
#endif
        let mutableString = NSMutableString(string: self)
        regex.enumerateMatches(in: self, options: [], range: NSMakeRange(0, characters.count)) { result, _, _ in
            guard let result = result else { return }
            let range = result.range
            let matched = mutableString.substring(with: range)
            mutableString.replaceCharacters(in: range, with: replacement(matched))
        }
        return String(describing: mutableString)
    }
    
    func transformFullHalf(_ string: String, reverse: Bool) -> String {
        let mutableString = NSMutableString(string: string)
#if os(Linux)
        let cfMutableString = unsafeBitCast(mutableString, to: CFMutableString.self)
#else
        let cfMutableString = mutableString as CFMutableString
#endif
        CFStringTransform(cfMutableString, nil, kCFStringTransformFullwidthHalfwidth, reverse)
        return String(describing: cfMutableString)
    }
    
    var full: String {
        return transformFullHalf(self, reverse: true)
    }
    
    var half: String {
        return transformFullHalf(self, reverse: false)
    }
}

extension JapaneseFilter: StringFilterType {
    func transform(_ string: String) -> String {
        switch (from, to) {
        case (.hiragana, .katakana):
            return string.shift(Distance.kana, pattern: "\\p{Hiragana}")
        case (.katakana, .hiragana):
            return string.shift(-Distance.kana, pattern: "\\p{Katakana}")
        case (.half(.alphabet), .full(.alphabet)):
            return string.shift(Distance.alnum, pattern: "[a-zA-Z]")
        case (.full(.alphabet), .half(.alphabet)):
            return string.shift(-Distance.alnum, pattern: "[ａ-ｚＡ-Ｚ]")
        case (.half(.number), .full(.number)):
                return string.shift(Distance.alnum, pattern: "[0-9]")
        case (.full(.number), .half(.number)):
            return string.shift(-Distance.alnum, pattern: "[０-９]")
        case (.half(.katakana), .full(.katakana)):
            return string.replace("\\p{Katakana}") { $0.full }
        case (.full(.katakana), .half(.katakana)):
            return string.replace("\\p{Katakana}") { $0.half }
        default:
            return string
        }
    }
}

