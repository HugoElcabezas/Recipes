//
//  Recipe.swift
//  Recipes
//
//  Created by Hugo Sevilla Gómez Llanos on 09/12/24.
//
import Foundation

struct Recipe: Codable, Identifiable {
    var id: String { uuid }
    let cuisine: String
    let name: String
    let photo_url_small: String?
    let photo_url_large: String?
    let uuid: String
    let source_url: String?
    let youtube_url: String?
}
