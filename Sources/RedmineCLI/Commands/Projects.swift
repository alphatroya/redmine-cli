//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import ArgumentParser
import Foundation
import Redmine

struct Projects: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Fetch all project id's from the tracker",
        subcommands: [
            Members.self,
        ]
    )

    func run() throws {
        let projects = try Redmine.kProjectsService.all.get()
        print(projects.sorted(by: { $0.id < $1.id }).renderTextTable())
    }
}
