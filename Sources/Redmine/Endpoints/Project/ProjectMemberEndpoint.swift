//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

struct ProjectMemberEndpoint: RequestTarget, EndpointDescription {
    let project: ProjectID

    var method: Method {
        .get
    }

    var path: String {
        "projects/\(project)/memberships"
    }
}
