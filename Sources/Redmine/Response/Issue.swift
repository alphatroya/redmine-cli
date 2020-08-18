//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

public struct Issue: Decodable {
    public let id: Int
    public let assignedTo: User
    public let author: User
}

extension Issue: ContainerKeySpecifier {
    static let containerKey: String = "issue"
}
