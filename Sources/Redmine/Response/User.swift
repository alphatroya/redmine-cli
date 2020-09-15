//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

public enum NewAssignee: Encodable {
    case id(UserID)

    // MARK: Public

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .id(id):
            try container.encode(id)
        }
    }
}

public typealias UserID = Int

public struct User: Decodable {
    public let id: UserID
    public let name: String
}
