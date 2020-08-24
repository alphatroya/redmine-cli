//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

public let kIssueStatusService: IssueStatusServiceProtocol = IssueStatusService(requestProvider: RequestProvider())
public let kIssueService: IssueServiceProtocol = IssueService(requestProvider: RequestProvider())
public let kProjectsService: ProjectManagerProtocol = ProjectManager(requestProvider: RequestProvider())
