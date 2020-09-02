//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation
import TextHighlighter
import XCTest

class GherkinHighlighterTests: XCTestCase {
    func testShouldSuccessfullyHighlightItems() {
        struct Case {
            let input: String
            let expected: String
        }

        let cases: [Case] = [
            .init(input: "Дано: 1", expected: "**Дано:** 1"),
            .init(input: "Дано: 1\nТогда: 2", expected: "**Дано:** 1\n**Тогда:** 2"),
            .init(input: "Дано: 1\n\nТогда: 2", expected: "**Дано:** 1\n\n**Тогда:** 2"),
            .init(input: "Дано: 1\nTest\nТогда: 2", expected: "**Дано:** 1\nTest\n**Тогда:** 2"),
            .init(input: "Дано: дано: 1\nTest\nТогда: 2", expected: "**Дано:** дано: 1\nTest\n**Тогда:** 2"),
            .init(input: "   Дано: 1\nTest\n   Тогда: 2", expected: "   **Дано:** 1\nTest\n   **Тогда:** 2"),
            .init(input: "Plain test\nSecond line", expected: "Plain test\nSecond line"),
        ]

        for testCase in cases {
            let result = GherkinHighlighter.highlight(testCase.input)
            XCTAssertEqual(result, testCase.expected)
        }
    }
}
