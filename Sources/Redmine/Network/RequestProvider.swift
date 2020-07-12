//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

protocol RequestProviderProtocol {
    func sync(_ request: RequestTarget) -> Result<Data, Swift.Error>
    func sync<Response: Decodable>(_ request: RequestTarget) -> Result<Response, Swift.Error>
}

final class RequestProvider: RequestProviderProtocol {
    enum Error: Swift.Error {
        case emptyData
    }

    func sync(_ request: RequestTarget) -> Result<Data, Swift.Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<Data, Swift.Error>!
        do {
            let urlSession = URLSession(configuration: .default)
            let request = try request.asURLRequest()
            if ProcessInfo.processInfo.environment["DEBUG"] != nil {
                print(request.cURLRepresentation)
            }
            urlSession.dataTask(with: request) { data, _, error in
                defer {
                    semaphore.signal()
                }
                if let error = error {
                    result = .failure(error)
                    return
                }
                guard let data = data else {
                    result = .failure(RequestProvider.Error.emptyData)
                    return
                }
                result = .success(data)
            }
            .resume()
        } catch {
            result = .failure(error)
        }
        semaphore.wait()
        return result
    }

    func sync<Response: Decodable>(_ request: RequestTarget) -> Result<Response, Swift.Error> {
        sync(request)
            .flatMap { data in
                Result<Response, Swift.Error> {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    return try decoder.decode(Response.self, from: data)
                }
            }
    }
}
