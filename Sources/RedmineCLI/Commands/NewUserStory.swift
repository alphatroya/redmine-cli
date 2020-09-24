//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import ArgumentParser
import Foundation
import Redmine
import TextHighlighter

struct NewUserStory: ParsableCommand {
    // MARK: Internal

    static let configuration: CommandConfiguration = .init(abstract: "Create a new user story task")

    @Option(help: "Title prefix for a new user story")
    var titlePrefix = "[US]"

    @Option(help: "Tracker type ID")
    var tracker: Redmine.Tracker.Identifier

    @Option(help: "Project for a new user story")
    var project: Redmine.ProjectID

    @Option(help: "Parent task for a new user story")
    var epic: Redmine.IssueID

    @Option(help: "Assign task to this user")
    var assign: Redmine.UserID

    @Option(help: "Estimated value")
    var estimated: Int = 1

    @Flag(name: .shortAndLong, help: "Enable verbose logging")
    var verbose: Bool = false

    func run() throws {
        let userInput = try requestInput(fileType: ".feature", verbose: verbose)
        let components = userInput.notes.components(separatedBy: "\n\n")
        guard components.count > 1 else {
            print("You should enter title and description separated by one empty line")
            throw ExitCode(1)
        }
        let title = [titlePrefix, String(components[0])].joined(separator: " ")
        var description = GherkinHighlighter.highlight(String(components.dropFirst().joined(separator: "\n\n")))
        if let reqURL = requestRequirementsDocURL() {
            description.append("\n")
            description.append(reqURL)
        }

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
                    parentIssueId: epic
                )
            ).get()
            print(issue.id)
            removeTemporaryFile(fileURL: userInput.fileURL, verbose: verbose)
        } catch {
            print("Error occurred, keep comment file at url: \(userInput.fileURL)")
            throw error
        }
    }

    // MARK: Private

    private func requestRequirementsDocURL() -> String? {
        print("Введите ссылку на ТЗ или пустую строку если не хотите прикладывать ссылку:")
        repeat {
            guard let line = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines), !line.isEmpty else {
                print("Введена пустая строка, ссылка на ТЗ не будет приложена")
                return nil
            }
            guard URL(string: line) != nil, line.hasPrefix("http") else {
                print("\nВведенная строка не является ссылкой, введите данные еще раз:")
                continue
            }
            return "[ТЗ](\(line))"
        } while true
    }
}

extension NewUserStory: UserInputRequester {}
