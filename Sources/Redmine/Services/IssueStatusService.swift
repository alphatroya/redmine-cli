//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

public protocol IssueStatusServiceProtocol {
    func all() -> Result<[IssueStatus], Error>
}

public final class IssueStatusService: IssueStatusServiceProtocol {
    // MARK: Lifecycle

    init(requestProvider: RequestProviderProtocol) {
        self.requestProvider = requestProvider
    }

    // MARK: Public

    public func all() -> Result<[IssueStatus], Error> {
        requestProvider.sync(IssueStatusEndpoint())
            .map { (response: ResponseContainer<[IssueStatus]>) in response.result }
    }

    // MARK: Internal

    let requestProvider: RequestProviderProtocol
}
