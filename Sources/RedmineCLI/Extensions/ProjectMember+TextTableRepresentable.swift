//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation
import Redmine
import SwiftyTextTable

extension ProjectMember: TextTableRepresentable {
    public static var columnHeaders: [String] {
        ["ИМЯ", "ID", "РОЛИ"]
    }

    public var tableValues: [CustomStringConvertible] {
        [user.name, user.id, roles.map(\.name).joined(separator: ", ")]
    }
}
