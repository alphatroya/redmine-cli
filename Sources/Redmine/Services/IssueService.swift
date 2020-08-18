//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

public protocol IssueServiceProtocol {
    func issue(_: IssueID) -> Result<Issue, Error>
    func update(_ id: IssueID, comment: String, assignTo userID: UserID?) -> Result<Void, Error>
}

public final class IssueService: IssueServiceProtocol {
    let requestProvider: RequestProviderProtocol

    init(requestProvider: RequestProviderProtocol) {
        self.requestProvider = requestProvider
    }

    public func issue(_ id: IssueID) -> Result<Issue, Error> {
        requestProvider.sync(IssueEndpoint.get(id: id))
            .map { (response: ResponseContainer<Issue>) in response.result }
    }

    public func update(_ id: IssueID, comment: String, assignTo userID: UserID?) -> Result<Void, Error> {
        requestProvider.sync(IssueEndpoint.update(id: id, data: .init(notes: comment, assignedToId: userID)))
            .map { (_: Data) in () }
    }
}

public let kIssueService = IssueService(requestProvider: RequestProvider())
