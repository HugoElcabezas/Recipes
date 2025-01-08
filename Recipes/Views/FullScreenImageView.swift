//
//  FullScreenImageView.swift
//  Recipes
//
//  Created by Hugo Sevilla Gómez Llanos on 15/12/24.
//

import SwiftUI

struct FullscreenImageView: View {
    var image: UIImage
    var recipeName: String
    var cuisine: String
    var article: String?
    var youtubeLink: String?
    @Binding var isPresented: Bool
    @State private var isControlsVisible = true

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        isControlsVisible.toggle()
                    }
                }

            if isControlsVisible {
                Button(action: {
                    withAnimation {
                        isPresented = false
                    }
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .clipShape(Circle())
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }

            if isControlsVisible {
                VStack(alignment: .leading, spacing: 8) {
                    Text(recipeName)
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()

                    Text("Cuisine: \(cuisine)")
                        .font(.subheadline)
                        .foregroundColor(.white)

                    if let article = article,
                       let articleURL = URL(string: article),
                       !article.isEmpty {
                        Link("Read Article", destination: articleURL)
                            .foregroundColor(.blue)
                            .font(.subheadline)
                    }
                    if let youtubeLink = youtubeLink,
                       let youtubeURL = URL(string: youtubeLink),
                       !youtubeLink.isEmpty {
                        Link("Watch on YouTube", destination: youtubeURL)
                            .foregroundColor(.blue)
                            .font(.subheadline)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    Color.black.opacity(0.7)
                        .edgesIgnoringSafeArea(.bottom)
                )
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .statusBarHidden(true)
    }
}
