//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

public struct IssueStatus: Decodable {
    public typealias Identifier = Int

    public let id: Identifier
    public let name: String
}

extension IssueStatus: ContainerKeySpecifier {
    static var containerKey: String = "issueStatuses"
}
