//
// Redmine CLI
// Copyright © 2022 Alexey Korolev <alphatroya@gmail.com>
//

public struct IssueListItem: Decodable {
    public let id: Int
}

extension IssueListItem: ContainerKeySpecifier {
    static let containerKey: String = "issues"
}
