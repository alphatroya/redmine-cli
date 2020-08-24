//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

public protocol ProjectManagerProtocol {
    var all: Result<[Project], Error> { get }
}

final class ProjectManager: ProjectManagerProtocol {
    let requestProvider: RequestProviderProtocol

    init(requestProvider: RequestProviderProtocol) {
        self.requestProvider = requestProvider
    }

    var all: Result<[Project], Error> {
        requestProvider.sync(ProjectsEndpoint())
            .map { (response: ResponseContainer<[Project]>) in response.result }
    }
}
