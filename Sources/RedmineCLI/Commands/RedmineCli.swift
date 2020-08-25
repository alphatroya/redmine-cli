//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import ArgumentParser

struct RedmineCli: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "A CLI tool to working with Redmine task manager",
        subcommands: [
            Comment.self,
            Statuses.self,
            Projects.self,
            EditStatus.self,
        ]
    )

    @Flag(name: .long, help: "Print tool version")
    var version: Bool = false

    func run() throws {
        guard version else {
            throw CleanExit.helpRequest(RedmineCli.self)
        }
        print("0.0.11")
    }
}
