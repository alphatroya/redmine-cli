//
// iOS Color Mate
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

enum IssueEndpoint: RequestTarget, EndpointDescription {
    case update(id: IssueID, data: IssueUpdate)

    struct IssueWrapper: Encodable {
        let issue: IssueUpdate
    }

    var method: Method {
        switch self {
        case .update:
            return .put
        }
    }

    var path: String {
        switch self {
        case let .update(id, _):
            return "issues/\(id)"
        }
    }

    func body() throws -> Data {
        switch self {
        case let .update(_, data):
            return try encode(IssueWrapper(issue: data))
        }
    }
}
