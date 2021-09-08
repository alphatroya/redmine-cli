//
// Redmine CLI
// Copyright © 2021 Alexey Korolev <alphatroya@gmail.com>
//

import ArgumentParser

@main
struct RedmineCli: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "A CLI tool to working with Redmine task manager",
        version: "0.0.18",
        subcommands: [
            Comment.self,
            EditStatus.self,
            NewUserStory.self,
            NewFeature.self,
            Projects.self,
            Statuses.self,
            Trackers.self,
        ]
    )
}
