//
// Redmine CLI
// Copyright © 2021 Alexey Korolev <alphatroya@gmail.com>
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
    func removeTemporaryFile(fileURL: URL, verbose: Bool)
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
        print("Using temporary file at path: \(fileURL)")

        shellCMD("\(editor) \(fileURL.absoluteString)")

        guard let data = try? Data(contentsOf: fileURL),
            let notes = String(data: data, encoding: .utf8),
            !notes.isEmpty
        else {
            print("Input file is empty, aborting")
            throw ExitCode(1)
        }
        return .init(notes: notes, fileURL: fileURL)
    }

    func removeTemporaryFile(fileURL: URL, verbose: Bool) {
        do {
            try FileManager.default.removeItem(at: fileURL)
            if verbose {
                print("Temporary comment file was removed")
            }
        } catch {
            print("Failed to remove temporary file: \(error)")
        }
    }
}
