//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import ArgumentParser
import Foundation
import Redmine
import SwiftyTextTable

struct Trackers: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Fetch all trackers list"
    )

    func run() throws {
        let trackers = try Redmine.kTrackerService.all().get()
        print(trackers.sorted(by: { $0.id < $1.id }).renderTextTable())
    }
}
