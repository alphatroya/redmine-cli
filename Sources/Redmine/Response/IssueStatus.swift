//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

public struct IssueStatus: Decodable {
    public let id: Int
    public let name: String
}

extension IssueStatus: ContainerKeySpecifier {
    static var containerKey: String = "issueStatuses"
}
