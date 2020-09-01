//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

public struct Tracker: Decodable {
    public typealias Identifier = Int

    public let id: Identifier
    public let name: String
}

extension Tracker: ContainerKeySpecifier {
    static let containerKey: String = "trackers"
}
