# StringFilter

[![Build Status](https://travis-ci.org/tnantoka/StringFilter.svg?branch=master)](https://travis-ci.org/tnantoka/StringFilter) [![codecov.io](https://codecov.io/github/tnantoka/StringFilter/coverage.svg?branch=master)](https://codecov.io/github/tnantoka/StringFilter?branch=master) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

A swifty text converter.

## Installtion

### Swift Package Manager (SPM)

```:swift
.Package(url: "https://github.com/tnantoka/StringFilter.git", majorVersion: 0, minor: 0),
```

### CocoaPods

```:ruby
pod 'StringFilter'
```

### Carthage

```
github "tnantoka/StringFilter"
```

## Usage

```swift
import StringFilter

let message = "ifmmp-!xpsme"
let filters = [
    StringFilter.shift(-1),
    .capitalize,
    .replace("$", "!")
]
print(message.str_filter(filters)) // "Hello, World!"
```

### Built-in filters

Case | Source | Result
--- | --- | ---
`.capitalize` | `test` | `Test`
`.lowercase` | `TEST` | `test`
`.uppercase` | `test` | `TEST`
`.shift(1)` | `test` | `uftu`
`.repeat(2))` | `test` | `testtest`
`.replace("t", "T")` | `test` | `TesT`
`.japanese(.hiragana, .katakana)` | `あいうえお` | `アイウエオ`
`.japanese(.katakana, .hiragana)` | `アイウエオ` | `あいうえお`
`.japanese(.full(.alphabet), .half(.alphabet))` | `ＡＢＣＤＥ` | `ABCDE`
`.japanese(.half(.alphabet), .full(.alphabet))` | `ABCDE` | `ＡＢＣＤＥ`
`.japanese(.full(.number), .half(.number))` | `０１２３４５６７８９` | `0123456789`
`.japanese(.half(.number), .full(.number))` | `0123456789` | `０１２３４５６７８９`
`.japanese(.full(.katakana), .half(.katakana))` | `アイウエオ` | `ｱｲｳｴｵ`
`.japanese(.half(.katakana), .full(.katakana))` | `ｱｲｳｴｵ` | `アイウエオ`

### Custom filter

```swift
struct ExclaimFilter: StringFilterType {
    func transform(_ string: String) -> String {
        return string + "!"
    }
}

let customFilter = ExclaimFilter() * 3 * StringFilter.uppercase
print("Hello".str_filter(customFilter)) // "HELLO!!!"
```

## TODO

- [ ] Chinese numeral

## Acknowledgements

- https://github.com/objcio/functional-swift
- https://github.com/niwaringo/moji
- https://github.com/gimite/moji
- https://github.com/yoshitsugu/zen_to_i

