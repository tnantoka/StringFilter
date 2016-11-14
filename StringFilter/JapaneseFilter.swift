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
        default:
            return string
        }
    }
}

