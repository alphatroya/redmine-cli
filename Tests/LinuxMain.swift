//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import XCTest

import RedmineCLITests

var tests = [XCTestCaseEntry]()
tests += RedmineCLITests.allTests()
XCTMain(tests)
