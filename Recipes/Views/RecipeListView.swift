//
//  RecipeListView.swift
//  Recipes
//
//  Created by Hugo Sevilla Gómez Llanos on 09/12/24.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipesViewModel()
    @State private var selectedAPI = APIURLs.all[0]
    @State private var selectedRecipe: Recipe?
    @State private var selectedImage: UIImage?
    @State private var isImagePresented = false
    @State private var isImageLoading = false

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.recipes.isEmpty {
                    Text("No recipes available.")
                        .foregroundColor(.gray)
                } else {
                    List(viewModel.recipes) { recipe in
                        RecipeRowView(recipe: recipe, onImageTap: { selectedRecipe in
                            loadImage(for: selectedRecipe)
                        })
                    }
                    .refreshable {
                        await viewModel.loadRecipes(url: selectedAPI.1)
                    }
                }

                if isImageLoading {
                    ProgressView("Loading image...")
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        ForEach(APIURLs.all, id: \.1) { api in
                            Button {
                                selectedAPI = api
                                Task {
                                    await viewModel.loadRecipes(url: api.1)
                                }
                            } label: {
                                HStack {
                                    Text(api.0)
                                    if api.0 == selectedAPI.0 {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                        }
                    } label: {
                        HStack {
                            Text("\(selectedAPI.0)")
                            Image(systemName: "arrow.down.circle.fill")
                        }
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.loadRecipes(url: selectedAPI.1)
            }
        }
        .fullScreenCover(isPresented: $isImagePresented) {
            if let selectedRecipe = selectedRecipe, let selectedImage = selectedImage {
                FullscreenImageView(
                    image: selectedImage,
                    recipeName: selectedRecipe.name,
                    cuisine: selectedRecipe.cuisine,
                    article: selectedRecipe.source_url,
                    youtubeLink: selectedRecipe.youtube_url,
                    isPresented: $isImagePresented
                )
            }
        }
    }

    func loadImage(for recipe: Recipe) {
        if let urlString = recipe.photo_url_large,
           let url = URL(string: urlString) {
            isImageLoading = true
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    if let image = UIImage(data: data) {
                        print("Image loaded successfully")
                        await MainActor.run {
                            selectedRecipe = recipe
                            selectedImage = image
                            isImageLoading = false
                            isImagePresented = true
                        }
                    } else {
                        print("Failed to create UIImage from data")
                        await MainActor.run {
                            isImageLoading = false
                        }
                    }
                } catch {
                    print("Error loading image: \(error)")
                    await MainActor.run {
                        isImageLoading = false
                    }
                }
            }
        }
    }
}

#Preview {
    RecipeListView()
}
