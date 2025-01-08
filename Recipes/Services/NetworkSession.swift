//
//  RealNetworkSession.swift
//  Recipes
//
//  Created by Hugo Sevilla Gómez Llanos on 06/01/25.
//

import Foundation

class NetworkSession: NetworkSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse) {
        let session = URLSession.shared
        return try await session.data(from: url)
    }
}
