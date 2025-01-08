//
//  Untitled.swift
//  Recipes
//
//  Created by Hugo Sevilla Gómez Llanos on 06/01/25.
//

import Foundation

protocol NetworkSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}
