//
//  MockNetworkSession.swift
//  Recipes
//
//  Created by Hugo Sevilla Gómez Llanos on 06/01/25.
//

import Foundation
@testable import Recipes

class MockNetworkSession: NetworkSessionProtocol {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?

    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }
        return (mockData ?? Data(), mockResponse ?? HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!)
    }
}
