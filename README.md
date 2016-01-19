# StringFilter

A swifty text converter.

## Install

### Carthage

```
github "tnantoka/StringFilter"
```

### CocoaPods

```
pod 'StringFilter'
```

## Usage

```swift
import StringFilter

let message = "ifmmp-!xpsme"
let filters = [StringFilter.Shift(-1), .Capitalize, .Replace("$", "!")]
print(message.str_filter(filters)) // "Hello, World!"
```

### Built-in filters

Case | Source | Result
--- | --- | ---
`.Capitalize` | `test` | `Test`
`.Lowercase` | `TEST` | `test`
`.Uppercase` | `test` | `TEST`
`.Shift(1)` | `test` | `uftu`
`.Repeat(2))` | `test` | `testtest`
`.Replace("t", "T")` | `test` | `TesT`
`.Japanese(.Hiragana, .Katakana)` | `あいうえお` | `アイウエオ`
`.Japanese(.Katakana, .Hiragana)` | `アイウエオ` | `あいうえお`
`.Japanese(.Full(.Alphabet), .Half(.Alphabet)))` | `ＡＢＣＤＥ` | `ABCDE`
`.Japanese(.Half(.Alphabet), .Full(.Alphabet)))` | `ABCDE` | `ＡＢＣＤＥ`
`.Japanese(.Full(.Number), .Half(.Number)))` | `０１２３４５６７８９` | `0123456789`
`.Japanese(.Half(.Number), .Full(.Number)))` | `0123456789` | `０１２３４５６７８９`

### Custom filter

```swift
struct ExclaimFilter: StringFilterType {
    func transform(string: String) -> String {
        return string + "!"
    }
}

print("Hello".str_filter(ExclaimFilter() * 3 * StringFilter.Uppercase)) // "HELLO!!!"
```

## TODO

- [ ] Chinese numeral
- [ ] One-byte katakana 

## Acknowledgements

- https://github.com/objcio/functional-swift
- https://github.com/niwaringo/moji
- https://github.com/gimite/moji
- https://github.com/yoshitsugu/zen_to_i

