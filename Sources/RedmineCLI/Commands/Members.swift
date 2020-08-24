//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import ArgumentParser
import Foundation
import Redmine

struct Members: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Fetch all members for a project"
    )

    @Argument(help: "Project ID")
    var project: ProjectID

    func run() throws {
        let members = try Redmine.kProjectsService.members(for: project).get()
        print(members.sorted(by: { $0.user.name < $1.user.name }).renderTextTable())
    }
}
