//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation
import Redmine
import SwiftyTextTable

extension Tracker: TextTableRepresentable {
    public static let columnHeaders: [String] = ["Название", "ID"]
    public var tableValues: [CustomStringConvertible] {
        [name, id]
    }
}
