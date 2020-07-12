//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

struct IssueResponse: Decodable {
    let issue: Issue
}

public struct Issue: Decodable {
    public let id: Int
    public let assignedTo: User
    public let author: User
}
