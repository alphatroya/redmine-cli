//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

protocol ContainerKeySpecifier {
    static var containerKey: String { get }
}

struct ResponseContainer<T: Decodable>: Decodable where T: ContainerKeySpecifier {
    private struct AnyCodingKeys: CodingKey {
        var stringValue: String

        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int? {
            nil
        }

        init?(intValue _: Int) {
            nil
        }
    }

    struct DecodingFailure: Error {}

    let result: T

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AnyCodingKeys.self)
        guard let key = AnyCodingKeys(stringValue: T.containerKey) else {
            throw DecodingFailure()
        }
        result = try container.decode(T.self, forKey: key)
    }
}

extension Array: ContainerKeySpecifier where Element: ContainerKeySpecifier {
    static var containerKey: String {
        Self.Element.containerKey
    }
}
