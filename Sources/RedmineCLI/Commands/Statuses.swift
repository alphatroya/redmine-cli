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

    @Option(help: "Batch limit for request")
    var limit = 1000

    @Option(help: "Offset for request")
    var offset = 0

    func run() throws {
        let statuses = try Redmine.kIssueStatusService.all(Pagination(limit: limit, offset: offset)).get()
        print(statuses.sorted(by: { $0.id < $1.id }).renderTextTable())
    }
}
