//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import ArgumentParser

struct Main: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "A CLI tool to working with Redmine task manager",
        subcommands: [
            Comment.self,
        ]
    )

    @Flag(name: .long, help: "Print tool version")
    var version: Bool = false

    func run() throws {
        guard version else {
            throw CleanExit.helpRequest(Main.self)
        }
        print("0.0.1")
    }
}
