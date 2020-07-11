//
// iOS Color Mate
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

public protocol IssueServiceProtocol {
    func update(_: IssueID, comment: String) -> Result<Void, Error>
}

public final class IssueService: IssueServiceProtocol {
    let requestProvider: RequestProviderProtocol

    init(requestProvider: RequestProviderProtocol) {
        self.requestProvider = requestProvider
    }

    public func update(_ id: IssueID, comment: String) -> Result<Void, Error> {
        requestProvider.sync(IssueEndpoint.update(id: id, data: .init(notes: comment)))
            .map { (_: Data) in () }
    }
}

public let kIssueService = IssueService(requestProvider: RequestProvider())
