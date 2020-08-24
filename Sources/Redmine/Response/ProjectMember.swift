//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

public struct ProjectMember: Decodable {
    public struct Role: Decodable {
        public let name: String
    }

    public let id: Int
    public let user: User
    public let roles: [Role]
}

extension ProjectMember: ContainerKeySpecifier {
    static let containerKey: String = "memberships"
}
