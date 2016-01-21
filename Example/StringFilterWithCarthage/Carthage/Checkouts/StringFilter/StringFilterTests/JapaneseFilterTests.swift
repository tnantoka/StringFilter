//
//  JapaneseFilterTests.swift
//  StringFilter
//
//  Created by Tatsuya Tobioka on 1/18/16.
//  Copyright © 2016 Tatsuya Tobioka. All rights reserved.
//

import XCTest
@testable import StringFilter

class JapaneseFilterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

    func testKana() {
        XCTAssertEqual("あいうえおＡ".str_filter(.Japanese(.Hiragana, .Katakana)), "アイウエオＡ")
        XCTAssertEqual("アイウエオＡ".str_filter(.Japanese(.Katakana, .Hiragana)), "あいうえおＡ")
    }
    
    func testAlphabet() {
        XCTAssertEqual("ＡＢＣＤＥあ".str_filter(.Japanese(.Full(.Alphabet), .Half(.Alphabet))), "ABCDEあ")
        XCTAssertEqual("ABCDEあ".str_filter(.Japanese(.Half(.Alphabet), .Full(.Alphabet))), "ＡＢＣＤＥあ")
    }
    
    func testNumber() {
        XCTAssertEqual("０１２３４５６７８９あ".str_filter(.Japanese(.Full(.Number), .Half(.Number))), "0123456789あ")
        XCTAssertEqual("0123456789あ".str_filter(.Japanese(.Half(.Number), .Full(.Number))), "０１２３４５６７８９あ")
    }
    
    func testDefault() {
        XCTAssertEqual("test".str_filter(.Japanese(.Alphabet, .Alphabet)), "test")
    }
}
