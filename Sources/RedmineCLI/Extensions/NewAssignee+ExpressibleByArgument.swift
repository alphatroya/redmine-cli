//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import ArgumentParser
import Foundation
import Redmine

extension NewAssignee: ExpressibleByArgument {
    public init?(argument: String) {
        if let id = UserID(argument) {
            self = .id(id)
        } else {
            return nil
        }
    }
}
