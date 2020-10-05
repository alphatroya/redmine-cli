//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import ArgumentParser

struct RedmineCli: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "A CLI tool to working with Redmine task manager",
        version: "0.0.14",
        subcommands: [
            Comment.self,
            EditStatus.self,
            NewUserStory.self,
            Projects.self,
            Statuses.self,
            Trackers.self,
        ]
    )
}
