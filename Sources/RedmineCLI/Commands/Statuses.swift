//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import ArgumentParser
import Redmine
import SwiftyTextTable

struct Statuses: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Fetch all status id's from the issue tracker"
    )

    func run() throws {
        let statuses = try Redmine.kIssueStatusService.all().get()
        print(statuses.sorted(by: { $0.id < $1.id }).renderTextTable())
    }
}
