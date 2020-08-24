//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

public protocol IssueStatusServiceProtocol {
    func all() -> Result<[IssueStatus], Error>
}

public final class IssueStatusService: IssueStatusServiceProtocol {
    let requestProvider: RequestProviderProtocol

    init(requestProvider: RequestProviderProtocol) {
        self.requestProvider = requestProvider
    }

    public func all() -> Result<[IssueStatus], Error> {
        requestProvider.sync(IssueStatusEndpoint())
            .map { (response: ResponseContainer<[IssueStatus]>) in response.result }
    }
}

public let kIssueStatusService = IssueStatusService(requestProvider: RequestProvider())
