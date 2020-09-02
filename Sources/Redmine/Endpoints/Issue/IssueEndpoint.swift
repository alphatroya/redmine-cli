//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

enum IssueEndpoint: RequestTarget, EndpointDescription {
    case get(id: IssueID)
    case update(id: IssueID, data: IssueUpdate)
    case new(NewIssuePayload)

    // MARK: Internal

    struct IssueWrapper<Data: Encodable>: Encodable {
        let issue: Data
    }

    var method: Method {
        switch self {
        case .get:
            return .get
        case .update:
            return .put
        case .new:
            return .post
        }
    }

    var path: String {
        switch self {
        case let .update(id, _), let .get(id):
            return "issues/\(id)"
        case .new:
            return "issues"
        }
    }

    func body() throws -> Data? {
        switch self {
        case .get:
            return nil
        case let .update(_, data):
            return try encode(IssueWrapper(issue: data))
        case let .new(data):
            return try encode(IssueWrapper(issue: data))
        }
    }
}
