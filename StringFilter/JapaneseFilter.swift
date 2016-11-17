//
//  JapaneseFilter.swift
//  StringFilter
//
//  Created by Tatsuya Tobioka on 1/18/16.
//  Copyright © 2016 Tatsuya Tobioka. All rights reserved.
//

import Foundation

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
    
    func replace(_ pattern: String, replacement: (String) -> String) -> String {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return self }
        let mutableString = NSMutableString(string: self)
        regex.enumerateMatches(in: self, options: [], range: NSMakeRange(0, characters.count)) { result, _, _ in
            guard let result = result else { return }
            let range = result.range
            let matched = mutableString.substring(with: range)
            mutableString.replaceCharacters(in: range, with: replacement(matched))
        }
        return mutableString as String
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
            return string.replace("\\p{Katakana}") { full($0) }
        case (.full(.katakana), .half(.katakana)):
            return string.replace("\\p{Katakana}") { half($0) }
        default:
            return string
        }
    }
    
    func transformFullHalf(_ string: String, reverse: Bool) -> String {
        let mutableString = NSMutableString(string: string)
        CFStringTransform(mutableString, nil, kCFStringTransformFullwidthHalfwidth, reverse)
        return mutableString as String
    }
    
    func full(_ string: String) -> String {
        return transformFullHalf(string, reverse: true)
    }
    
    func half(_ string: String) -> String {
        return transformFullHalf(string, reverse: false)
    }
}

