//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import ArgumentParser
import CBridge
import Foundation
import Redmine

struct Comment: ParsableCommand {
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
        let editor = ProcessInfo.processInfo.environment["EDITOR"] ?? "vi"
        if verbose {
            print("Using editor: \(editor)")
        }

        let directory = NSTemporaryDirectory()
        let fileName = UUID().uuidString + ".md"
        let fileURL = URL(fileURLWithPath: [directory, fileName].joined())
        if verbose {
            print("Creating temporary comment file at path: \(fileURL)")
        }

        shellCMD("\(editor) \(fileURL.absoluteString)")

        guard let data = try? Data(contentsOf: fileURL),
            let notes = String(data: data, encoding: .utf8),
            !notes.isEmpty
        else {
            throw ValidationError("You aren't entered any text, aborting")
        }

        do {
            let service = Redmine.kIssueService
            let issueResponse = try fetchIssue(service: service)
            _ = try service.update(issue, comment: notes, assignTo: reject ? issueResponse.author.id : nil).get()
            print("Updated issue with id: \(issue)")
        } catch {
            print("Error occured, keep comment file at url: \(fileURL)")
            throw error
        }

        removeTemporaryFile(fileURL: fileURL)
    }

    private func fetchIssue(service: IssueService) throws -> Issue {
        try service.issue(issue).get()
    }

    private func removeTemporaryFile(fileURL: URL) {
        do {
            try FileManager.default.removeItem(at: fileURL)
            if verbose {
                print("Removed temporary comment file")
            }
        } catch {
            print("failed to remove tmp file: \(error)")
        }
    }
}
