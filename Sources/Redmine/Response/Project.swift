//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

public struct Project: Decodable {
    public let id: Int
    public let name: String
}

extension Project: ContainerKeySpecifier {
    static var containerKey: String = "projects"
}
