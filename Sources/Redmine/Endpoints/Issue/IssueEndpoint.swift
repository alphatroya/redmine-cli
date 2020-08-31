//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

enum IssueEndpoint: RequestTarget, EndpointDescription {
    case get(id: IssueID)
    case update(id: IssueID, data: IssueUpdate)

    // MARK: Internal

    struct IssueWrapper: Encodable {
        let issue: IssueUpdate
    }

    var method: Method {
        switch self {
        case .get:
            return .get
        case .update:
            return .put
        }
    }

    var path: String {
        switch self {
        case let .update(id, _), let .get(id):
            return "issues/\(id)"
        }
    }

    func body() throws -> Data? {
        switch self {
        case .get:
            return nil
        case let .update(_, data):
            return try encode(IssueWrapper(issue: data))
        }
    }
}
