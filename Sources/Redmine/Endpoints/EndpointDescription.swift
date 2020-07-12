//
// iOS Color Mate
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

enum EndpointDescriptionError: Error {
    case hostNotSet
    case hostNotValid
}

protocol EndpointDescription {
    var method: Method { get }
    var path: String { get }

    func body() throws -> Data?
    func host() throws -> URL
}

extension EndpointDescription {
    func host() throws -> URL {
        guard let urlString = ProcessInfo.processInfo.environment["REDMINE_HOST"] else {
            throw EndpointDescriptionError.hostNotSet
        }
        guard let url = URL(string: urlString) else {
            throw EndpointDescriptionError.hostNotValid
        }
        return url
    }

    func encode<Body: Encodable>(_ body: Body) throws -> Data {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return try encoder.encode(body)
    }
}
