//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

public struct Pagination {
    let limit, offset: Int

    public init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
    }

    var asQueryParams: [URLQueryItem] {
        [
            .init(name: "limit", value: "\(limit)"),
            .init(name: "offset", value: "\(offset)"),
        ]
    }
}
