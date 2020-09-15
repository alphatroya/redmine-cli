//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import ArgumentParser
import Foundation
import Redmine

struct EditStatus: ParsableCommand {
    // MARK: Internal

    enum IssueStatusOption: ExpressibleByArgument {
        case single(IssueStatus.Identifier)
        case row([IssueStatus.Identifier])

        // MARK: Lifecycle

        init?(argument: String) {
            let arguments = argument.split(separator: ",").compactMap { IssueStatus.Identifier($0) }
            switch arguments.count {
            case 0:
                return nil
            case 1:
                self = .single(arguments[0])
            default:
                self = .row(arguments)
            }
        }
    }

    static var configuration = CommandConfiguration(
        abstract: "Edit issue status and (optionally) assignee"
    )

    @Option(name: .shortAndLong, help: "Comma separated list of statuses for sequentially edit statuses")
    var status: IssueStatusOption

    @Option(name: .shortAndLong, help: "New assignee")
    var assignee: NewAssignee?

    @Argument(help: "Issue ID")
    var issueID: IssueID

    func run() throws {
        switch status {
        case let .single(id):
            try update(id)
        case let .row(ids):
            for id in ids {
                try update(id)
            }
        }
    }

    // MARK: Private

    private func update(_ statusID: IssueStatus.Identifier) throws {
        try kIssueService.update(issueID, status: statusID, assignTo: assignee).get()
    }
}
