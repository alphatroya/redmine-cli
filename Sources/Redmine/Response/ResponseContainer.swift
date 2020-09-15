//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

protocol ContainerKeySpecifier {
    static var containerKey: String { get }
}

struct ResponseContainer<T: Decodable>: Decodable where T: ContainerKeySpecifier {
    // MARK: Lifecycle

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AnyCodingKeys.self)
        guard let key = AnyCodingKeys(stringValue: T.containerKey) else {
            throw DecodingFailure()
        }
        result = try container.decode(T.self, forKey: key)
    }

    // MARK: Internal

    struct DecodingFailure: Error {}

    let result: T

    // MARK: Private

    private struct AnyCodingKeys: CodingKey {
        // MARK: Lifecycle

        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        init?(intValue _: Int) {
            nil
        }

        // MARK: Internal

        var stringValue: String

        var intValue: Int? {
            nil
        }
    }
}

extension Array: ContainerKeySpecifier where Element: ContainerKeySpecifier {
    static var containerKey: String {
        Self.Element.containerKey
    }
}
