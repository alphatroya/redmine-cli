//
// Redmine CLI
// Copyright © 2022 Alexey Korolev <alphatroya@gmail.com>
//

import ArgumentParser
import Foundation
import Redmine

struct Issues: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Fetch all issues in the project"
    )

    @Option(help: "Project ID")
    var project: ProjectID

    @Option(help: "Filter by status")
    var status: Redmine.IssueStatus.Identifier?

    func run() throws {
        let issues = try Redmine.kIssueService.all(project, status: status).get()
        print(issues.map { "\($0.id)" }.joined(separator: "\n"))
    }
}
