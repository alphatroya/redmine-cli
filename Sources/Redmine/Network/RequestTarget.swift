//
// iOS Color Mate
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

enum Method: String {
    case get, post, put, delete
}

struct AuthEmptyError: Error {}

protocol RequestTarget {
    func asURLRequest() throws -> URLRequest
}

extension RequestTarget where Self: EndpointDescription {
    private var apiFormat: String {
        "json"
    }

    func asURLRequest() throws -> URLRequest {
        var url = try host()
        url.appendPathComponent(path)
        url.appendPathExtension(apiFormat)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.uppercased()
        guard let auth = ProcessInfo.processInfo.environment["REDMINE_API_KEY"], !auth.isEmpty else {
            throw AuthEmptyError()
        }
        request.addValue(auth, forHTTPHeaderField: "X-Redmine-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try body()
        print(request)
        return request
    }
}
