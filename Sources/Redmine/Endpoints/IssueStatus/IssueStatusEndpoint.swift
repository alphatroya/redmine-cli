//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

struct IssueStatusEndpoint: RequestTarget, EndpointDescription {
    let pagination: Pagination

    var method: Method {
        .get
    }

    var path: String {
        "issue_statuses"
    }

    var queryItems: [URLQueryItem] {
        pagination.asQueryParams
    }

    func body() throws -> Data? {
        nil
    }
}
