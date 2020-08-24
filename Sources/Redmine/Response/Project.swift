//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

public typealias ProjectID = Int

public struct Project: Decodable {
    public let id: ProjectID
    public let name: String
}

extension Project: ContainerKeySpecifier {
    static let containerKey: String = "projects"
}
