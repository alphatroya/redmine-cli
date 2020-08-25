//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import ArgumentParser
import Foundation
import Redmine

struct EditStatus: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Edit issue status and optionally assignee"
    )

    enum IssueStatusOption: ExpressibleByArgument {
        case single(IssueStatus.Identifier)
        case row([IssueStatus.Identifier])

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

    @Option(name: .shortAndLong, help: "Comma separated list of statuses for sequentially edit statuses")
    var status: IssueStatusOption

    @Option(name: .shortAndLong, help: "New assignee, use me for assign to yourself")
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

    private func update(_ statusID: IssueStatus.Identifier) throws {
        try kIssueService.update(issueID, status: statusID, assignTo: assignee).get()
    }
}
