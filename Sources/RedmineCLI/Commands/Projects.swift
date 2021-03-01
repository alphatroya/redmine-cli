//
// Redmine CLI
// Copyright © 2021 Alexey Korolev <alphatroya@gmail.com>
//

import ArgumentParser
import Foundation
import Redmine

struct Projects: ParsableCommand {
    // MARK: Internal

    static var configuration = CommandConfiguration(
        abstract: "Fetch all project id's from the tracker",
        subcommands: [
            Members.self,
        ]
    )

    @Option(name: .long, help: "Size for projects request page")
    var limit: Int = 50

    func run() throws {
        var offset = 0
        try print(
            Redmine.kProjectsService.get(limit: limit, offset: offset)
                .get()
                .renderTextTable()
        )

        printNewPagePrompt()
        while let input = readLine()?.lowercased() {
            switch input {
            case "y":
                offset += limit
                let nextPage = try Redmine.kProjectsService.get(limit: limit, offset: offset).get()
                guard !nextPage.isEmpty else {
                    return
                }
                print(nextPage.renderTextTable())
            case "n":
                return
            default:
                print("You should answer Y or N")
            }
            printNewPagePrompt()
        }
    }

    // MARK: Private

    private func printNewPagePrompt() {
        print("Request next page? [Y/N]: ", terminator: "")
    }
}
