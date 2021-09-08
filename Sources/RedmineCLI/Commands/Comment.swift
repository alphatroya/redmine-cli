//
// Redmine CLI
// Copyright © 2021 Alexey Korolev <alphatroya@gmail.com>
//

import ArgumentParser
import Foundation
import Redmine

struct Comment: ParsableCommand {
    // MARK: Internal

    static var configuration = CommandConfiguration(
        abstract: "Add a comment to the specified issue"
    )

    @Argument(help: "Issue identifier")
    var issue: Redmine.IssueID

    @Flag(name: .shortAndLong, help: "Enable verbose logging")
    var verbose: Bool = false

    @Flag(name: .shortAndLong, help: "Assign task to the author")
    var reject: Bool = false

    func run() throws {
        let userInput = try requestInput(fileType: ".md", verbose: verbose)

        do {
            let service = Redmine.kIssueService
            let issueResponse = try fetchIssue(service: service)
            _ = try service.update(issue, comment: userInput.notes, assignTo: reject ? issueResponse.author.id : nil).get()
            if verbose {
                print("Updated issue with id: \(issue)")
            }
        } catch {
            print("Error occurred, keep comment file at url: \(userInput.fileURL)")
            throw error
        }

        removeTemporaryFile(fileURL: userInput.fileURL, verbose: verbose)
    }

    // MARK: Private

    private func fetchIssue(service: IssueService) throws -> Issue {
        try service.issue(issue).get()
    }
}

extension Comment: UserInputRequester {}
