//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

public struct NewIssueCustomField: Encodable {
    // TODO: temporary hack for new issue creation, remove after this will be moved in configuration files
    public static let easy: Self = .init(id: 20, value: "Простое / Типовое")

    public let id: Int
    public let value: String
}

public struct NewIssuePayload: Encodable {
    // MARK: Lifecycle

    public init(
        projectId: ProjectID,
        trackerId: Tracker.Identifier,
        subject: String,
        description: String,
        assignedToId: UserID,
        estimatedHours: Int,
        parentIssueId: IssueID
    ) {
        self.projectId = projectId
        self.trackerId = trackerId
        self.subject = subject
        self.description = description
        self.assignedToId = assignedToId
        self.estimatedHours = estimatedHours
        self.parentIssueId = parentIssueId
        customFields = [.easy]
    }

    // MARK: Public

    public let projectId: ProjectID
    public let trackerId: Tracker.Identifier
    public let subject: String
    public let description: String
    public let assignedToId: UserID
    public let estimatedHours: Int
    public let parentIssueId: IssueID
    public let customFields: [NewIssueCustomField]
}
