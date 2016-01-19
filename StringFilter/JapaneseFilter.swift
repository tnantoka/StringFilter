//
//  JapaneseFilter.swift
//  StringFilter
//
//  Created by Tatsuya Tobioka on 1/18/16.
//  Copyright © 2016 Tatsuya Tobioka. All rights reserved.
//

import Foundation

public indirect enum JapaneseString {
    case Katakana
    case Hiragana
    case Alphabet
    case Number
    case Full(JapaneseString)
    case Half(JapaneseString)
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
    func shift(by: Int, pattern: String) -> String {
        return unicodeScalars.reduce("") {
            let origin = String($1)
            return $0 + (origin.isMatch(pattern) ? $1.shift(by) : origin)
        }
    }
}

extension JapaneseFilter: StringFilterType {
    func transform(string: String) -> String {
        switch (from, to) {
        case (.Hiragana, .Katakana):
            return string.shift(Distance.kana, pattern: "\\p{Hiragana}")
        case (.Katakana, .Hiragana):
            return string.shift(-Distance.kana, pattern: "\\p{Katakana}")
        case (.Half(.Alphabet), .Full(.Alphabet)):
            return string.shift(Distance.alnum, pattern: "[a-zA-Z]")
        case (.Full(.Alphabet), .Half(.Alphabet)):
            return string.shift(-Distance.alnum, pattern: "[ａ-ｚＡ-Ｚ]")
        case (.Half(.Number), .Full(.Number)):
                return string.shift(Distance.alnum, pattern: "[0-9]")
        case (.Full(.Number), .Half(.Number)):
            return string.shift(-Distance.alnum, pattern: "[０-９]")
        default:
            return string
        }
    }
}

