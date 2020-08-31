//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

public protocol IssueServiceProtocol {
    func issue(_: IssueID) -> Result<Issue, Error>
    func update(_ id: IssueID, comment: String, assignTo userID: UserID?) -> Result<Void, Error>
    func update(_ id: IssueID, status: IssueStatus.Identifier, assignTo assignee: NewAssignee?) -> Result<Void, Error>
}

public final class IssueService: IssueServiceProtocol {
    // MARK: Lifecycle

    init(requestProvider: RequestProviderProtocol) {
        self.requestProvider = requestProvider
    }

    // MARK: Public

    public func issue(_ id: IssueID) -> Result<Issue, Error> {
        requestProvider.sync(IssueEndpoint.get(id: id))
            .map { (response: ResponseContainer<Issue>) in response.result }
    }

    public func update(_ id: IssueID, comment: String, assignTo userID: UserID?) -> Result<Void, Error> {
        requestProvider.sync(IssueEndpoint.update(id: id, data: .init(notes: comment, assignedToId: userID.map { NewAssignee.id($0) })))
            .map { (_: Data) in () }
    }

    public func update(_ id: IssueID, status: IssueStatus.Identifier, assignTo assignee: NewAssignee?) -> Result<Void, Error> {
        requestProvider.sync(IssueEndpoint.update(id: id, data: .init(assignedToId: assignee, statusId: status)))
            .map { (_: Data) in () }
    }

    // MARK: Internal

    let requestProvider: RequestProviderProtocol
}
