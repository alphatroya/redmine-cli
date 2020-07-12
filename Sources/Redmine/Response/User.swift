//
// iOS Color Mate
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

public typealias UserID = Int

public struct User: Decodable {
    public let id: UserID
    public let name: String
}
