import XCTest
@testable import StringFilterTests

XCTMain([
    testCase(StringFilterTests.allTests),
    testCase(StringFilterTypeTests.allTests),
    testCase(JapaneseFilterTests.allTests),
])
