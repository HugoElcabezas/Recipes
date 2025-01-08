//
//  APIURLs.swift
//  Recipes
//
//  Created by Hugo Sevilla Gómez Llanos on 14/12/24.
//

import Foundation

struct APIURLs {
    static let validAPI = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
    static let malformedAPI = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
    static let emptyAPI = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!

    static let all: [(String, URL)] = [
        ("API Good", validAPI),
        ("API Malformed", malformedAPI),
        ("API Empty", emptyAPI)
    ]
}
