//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

public protocol ProjectManagerProtocol {
    func get(limit: Int, offset: Int) -> Result<[Project], Error>
    func members(for id: ProjectID) -> Result<[ProjectMember], Error>
}

final class ProjectManager: ProjectManagerProtocol {
    // MARK: Lifecycle

    init(requestProvider: RequestProviderProtocol) {
        self.requestProvider = requestProvider
    }

    // MARK: Internal

    let requestProvider: RequestProviderProtocol

    func get(limit: Int, offset: Int) -> Result<[Project], Error> {
        requestProvider.sync(ProjectsEndpoint(offset: offset, limit: limit))
            .map { (response: ResponseContainer<[Project]>) in response.result }
    }

    func members(for id: ProjectID) -> Result<[ProjectMember], Error> {
        requestProvider.sync(ProjectMemberEndpoint(project: id))
            .map { (response: ResponseContainer<[ProjectMember]>) in response.result }
    }
}
