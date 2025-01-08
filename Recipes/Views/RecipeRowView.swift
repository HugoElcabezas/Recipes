//
//  RecipeRow.swift
//  Recipes
//
//  Created by Hugo Sevilla Gómez Llanos on 09/12/24.
//

import SwiftUI

struct RecipeRowView: View {
    var recipe: Recipe
    var onImageTap: (Recipe) -> Void
    
    var body: some View {
        VStack {
            HStack {
                if let imageUrl = recipe.photo_url_small, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable().scaledToFit().frame(width: 150)
                        case .failure:
                            Image(systemName: "photo").resizable().scaledToFit().frame(width: 150)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .onTapGesture {
                        onImageTap(recipe)
                    }
                    .padding(.trailing, 10)
                }
                
                VStack(alignment: .leading) {
                    Text(recipe.name)
                        .font(.headline)
                    Text(recipe.cuisine)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, 2)
                    VStack(alignment: .leading, spacing: 5) {
                        if let sourceLink = recipe.source_url, let sourceURL = URL(string: sourceLink) {
                            LinkButtonView(title: "Article", icon: "doc.text", url: sourceURL)
                        }
                        if let youtubeLink = recipe.youtube_url, let youtubeURL = URL(string: youtubeLink) {
                            LinkButtonView(title: "YouTube", icon: "play.rectangle", url: youtubeURL)
                        }
                    }
                    .padding(.top, 5)
                }
            }
            .padding()
        }
    }
    
    func openURL(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
