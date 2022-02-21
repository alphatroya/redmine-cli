//
// Redmine CLI
// Copyright © 2022 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

enum IssueEndpoint: RequestTarget, EndpointDescription {
    case get(id: IssueID)
    case all(id: ProjectID, status: IssueStatus.Identifier?)
    case update(id: IssueID, data: IssueUpdate)
    case new(NewIssuePayload)

    // MARK: Internal

    struct IssueWrapper<Data: Encodable>: Encodable {
        let issue: Data
    }

    var method: Method {
        switch self {
        case .get, .all:
            return .get
        case .update:
            return .put
        case .new:
            return .post
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case let .all(id, status):
            var ret = [URLQueryItem(name: "project_id", value: "\(id)")]
            if let status = status {
                ret.append(.init(name: "status_id", value: "\(status)"))
            }
            return ret
        default:
            return []
        }
    }

    var path: String {
        switch self {
        case let .update(id, _), let .get(id):
            return "issues/\(id)"
        case .new, .all:
            return "issues"
        }
    }

    func body() throws -> Data? {
        switch self {
        case .get, .all:
            return nil
        case let .update(_, data):
            return try encode(IssueWrapper(issue: data))
        case let .new(data):
            return try encode(IssueWrapper(issue: data))
        }
    }
}
