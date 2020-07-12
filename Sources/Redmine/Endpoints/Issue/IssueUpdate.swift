//
// iOS Color Mate
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

struct IssueUpdate: Encodable {
    var notes: String
    var assignedToId: UserID?
}
