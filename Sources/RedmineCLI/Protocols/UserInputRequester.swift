//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import ArgumentParser
import CBridge
import Foundation

struct UserInput {
    let notes: String
    let fileURL: URL
}

protocol UserInputRequester {
    func requestInput(fileType: String, verbose: Bool) throws -> UserInput
}

extension UserInputRequester {
    func requestInput(fileType: String, verbose: Bool) throws -> UserInput {
        let editor = ProcessInfo.processInfo.environment["EDITOR"] ?? "vi"
        if verbose {
            print("Using editor: \(editor)")
        }

        let directory = NSTemporaryDirectory()
        let fileName = UUID().uuidString + fileType
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
        return .init(notes: notes, fileURL: fileURL)
    }
}
