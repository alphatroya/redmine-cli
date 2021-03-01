//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

struct ProjectsEndpoint: RequestTarget, EndpointDescription {
    let offset: Int
    let limit: Int

    var method: Method {
        .get
    }

    var path: String {
        "projects"
    }

    var queryItems: [URLQueryItem] {
        [
            .init(name: "limit", value: "\(limit)"),
            .init(name: "offset", value: "\(offset)"),
        ]
    }
}
