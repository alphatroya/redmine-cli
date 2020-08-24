//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

struct ProjectsEndpoint: RequestTarget, EndpointDescription {
    var method: Method {
        .get
    }

    var path: String {
        "projects"
    }
}
