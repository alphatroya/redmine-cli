//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

public protocol TrackersServiceProtocol {
    func all() -> Result<[Tracker], Error>
}

final class TrackersService: TrackersServiceProtocol {
    // MARK: Lifecycle

    init(requestProvider: RequestProviderProtocol) {
        self.requestProvider = requestProvider
    }

    // MARK: Internal

    let requestProvider: RequestProviderProtocol

    func all() -> Result<[Tracker], Error> {
        requestProvider.sync(TrackersEndpoint())
            .map { (response: ResponseContainer<[Tracker]>) in response.result }
    }
}
