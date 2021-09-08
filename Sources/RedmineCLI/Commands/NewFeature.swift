//
// Redmine CLI
// Copyright © 2021 Alexey Korolev <alphatroya@gmail.com>
//

import ArgumentParser
import Foundation
import Redmine
import TextHighlighter

struct NewFeature: ParsableCommand {
    static let configuration: CommandConfiguration = .init(abstract: "Create a new feature")

    @Option(help: "Tracker type ID")
    var tracker: Redmine.Tracker.Identifier

    @Option(help: "Project for a new feature")
    var project: Redmine.ProjectID

    @Option(help: "Assign task to this user")
    var assign: Redmine.UserID

    @Option(help: "Estimated value")
    var estimated: Int = 1

    @Flag(name: .shortAndLong, help: "Enable verbose logging")
    var verbose: Bool = false

    func run() throws {
        let userInput = try requestInput(fileType: ".md", verbose: verbose)
        let components = userInput.notes.components(separatedBy: "\n\n")
        guard components.count > 1 else {
            print("You should enter title and description separated by one empty line")
            throw ExitCode(1)
        }
        let title = String(components[0])
        let description = String(components.dropFirst().joined(separator: "\n\n"))
        do {
            let issueService = Redmine.kIssueService
            let issue = try issueService.new(
                .init(
                    projectId: project,
                    trackerId: tracker,
                    subject: title,
                    description: description,
                    assignedToId: assign,
                    estimatedHours: estimated,
                    parentIssueId: nil
                )
            ).get()
            print(issue.id)
            removeTemporaryFile(fileURL: userInput.fileURL, verbose: verbose)
        } catch {
            print("Error occurred, keep comment file at url: \(userInput.fileURL)")
            throw error
        }
    }
}

extension NewFeature: UserInputRequester {}
