//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

struct IssueStatusEndpoint: RequestTarget, EndpointDescription {
    var method: Method {
        .get
    }

    var path: String {
        "issue_statuses"
    }

    func body() throws -> Data? {
        nil
    }
}
