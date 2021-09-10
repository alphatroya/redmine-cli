//
// Redmine CLI
// Copyright © 2021 Alexey Korolev <alphatroya@gmail.com>
//

import ArgumentParser
import Foundation
import Redmine
import TextHighlighter

struct NewFeature: ParsableCommand {
    // MARK: Internal

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
        guard let title = requestTitle() else {
            print("Введена пустая строка, команда остановлена")
            return
        }
        let description = try requestInput(fileType: ".md", verbose: verbose)
        guard !description.notes.isEmpty else {
            print("Вы не написали описания для задачи, команда остановлена")
            return
        }
        do {
            let issueService = Redmine.kIssueService
            let issue = try issueService.new(
                .init(
                    projectId: project,
                    trackerId: tracker,
                    subject: title,
                    description: description.notes,
                    assignedToId: assign,
                    estimatedHours: estimated,
                    parentIssueId: nil
                )
            ).get()
            print(issue.id)
            removeTemporaryFile(fileURL: description.fileURL, verbose: verbose)
        } catch {
            print("Error occurred, keep comment file at url: \(description.fileURL)")
            throw error
        }
    }

    // MARK: Private

    private func requestTitle() -> String? {
        print("Введите заголовок будущей задачи")
        guard let line = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines), !line.isEmpty else {
            return nil
        }
        return line
    }
}

extension NewFeature: UserInputRequester {}
