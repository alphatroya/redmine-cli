//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

enum Method: String {
    case get, post, put, delete
}

struct BuildingURLError: Error {}

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
        guard var urlCom = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw BuildingURLError()
        }

        if !queryItems.isEmpty {
            urlCom.queryItems = queryItems
        }

        guard let resultURL = urlCom.url else {
            throw BuildingURLError()
        }
        var request = URLRequest(url: resultURL)
        request.httpMethod = method.rawValue.uppercased()
        guard let auth = ProcessInfo.processInfo.environment["REDMINE_API_KEY"], !auth.isEmpty else {
            throw AuthEmptyError()
        }
        request.addValue(auth, forHTTPHeaderField: "X-Redmine-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try body()
        return request
    }
}
