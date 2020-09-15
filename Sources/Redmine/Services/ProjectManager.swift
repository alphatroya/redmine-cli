//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

public protocol ProjectManagerProtocol {
    var all: Result<[Project], Error> { get }
    func members(for id: ProjectID) -> Result<[ProjectMember], Error>
}

final class ProjectManager: ProjectManagerProtocol {
    // MARK: Lifecycle

    init(requestProvider: RequestProviderProtocol) {
        self.requestProvider = requestProvider
    }

    // MARK: Internal

    let requestProvider: RequestProviderProtocol

    var all: Result<[Project], Error> {
        requestProvider.sync(ProjectsEndpoint())
            .map { (response: ResponseContainer<[Project]>) in response.result }
    }

    func members(for id: ProjectID) -> Result<[ProjectMember], Error> {
        requestProvider.sync(ProjectMemberEndpoint(project: id))
            .map { (response: ResponseContainer<[ProjectMember]>) in response.result }
    }
}
