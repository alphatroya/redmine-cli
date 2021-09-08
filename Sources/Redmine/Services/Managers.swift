//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

public let kIssueStatusService: IssueStatusServiceProtocol = IssueStatusService(requestProvider: RequestProvider())
public let kIssueService = IssueService(requestProvider: RequestProvider())
public let kProjectsService: ProjectManagerProtocol = ProjectManager(requestProvider: RequestProvider())
public let kTrackerService: TrackersServiceProtocol = TrackersService(requestProvider: RequestProvider())
