//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

public struct Pagination {
    // MARK: Lifecycle

    public init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
    }

    // MARK: Internal

    let limit, offset: Int

    var asQueryParams: [URLQueryItem] {
        [
            .init(name: "limit", value: "\(limit)"),
            .init(name: "offset", value: "\(offset)"),
        ]
    }
}
