//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation
import Redmine
import SwiftyTextTable

extension Project: TextTableRepresentable {
    public static var columnHeaders: [String] {
        ["НАЗВАНИЕ", "ID"]
    }

    public var tableValues: [CustomStringConvertible] {
        [name, id]
    }
}
