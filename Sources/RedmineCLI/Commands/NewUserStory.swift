//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import ArgumentParser
import Foundation
import Redmine

struct NewUserStory: ParsableCommand {
    static let configuration: CommandConfiguration = .init(abstract: "Create a new user story task")

    @Option(name: .shortAndLong, help: "Tracker type ID")
    var tracker: Redmine.Tracker.Identifier

    @Option(name: .shortAndLong, help: "Project for a new user story")
    var project: Redmine.ProjectID

    @Option(name: .shortAndLong, help: "Parent task for a new user story")
    var epic: Redmine.IssueID

    @Flag(name: .shortAndLong, help: "Enable verbose logging")
    var verbose: Bool = false

    func run() throws {
        let userInput = try requestInput(fileType: ".feature", verbose: verbose)
        let components = userInput.notes.components(separatedBy: "\n\n")
        guard components.count > 1 else {
            print("You should enter title and description separated by newline symbol")
            throw ExitCode(1)
        }
        let title = String(components[0])
        let description = String(components.dropFirst().joined(separator: "\n\n"))
//        curl -v -X POST -H 'Accept: application/json' -H 'Content-Type: application/json' -d '{ "issue": { "project_id": 901, "tracker_id": 10, "subject":"Test", "description":"Desc", "assigned_to_id": 44, "estimated_hours": 1, "parent_issue_id": 71123, "custom_fields":[{"id":20,"value":"Простое / Типовое"}] } }' 'https:///issues.json' | jq
    }
}

extension NewUserStory: UserInputRequester {}
