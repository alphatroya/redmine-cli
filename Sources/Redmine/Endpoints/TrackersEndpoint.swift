//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

struct TrackersEndpoint: RequestTarget, EndpointDescription {
    var method: Method {
        .get
    }

    var path: String {
        "trackers"
    }
}
