//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

public protocol IssueStatusServiceProtocol {
    func all(_ page: Pagination) -> Result<[IssueStatus], Error>
}

public final class IssueStatusService: IssueStatusServiceProtocol {
    let requestProvider: RequestProviderProtocol

    init(requestProvider: RequestProviderProtocol) {
        self.requestProvider = requestProvider
    }

    public func all(_ page: Pagination) -> Result<[IssueStatus], Error> {
        requestProvider.sync(IssueStatusEndpoint(pagination: page))
            .map { (response: ResponseContainer<[IssueStatus]>) in response.result }
    }
}

public let kIssueStatusService = IssueStatusService(requestProvider: RequestProvider())
