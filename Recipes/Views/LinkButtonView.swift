//
//  LinkButtonView.swift
//  Recipes
//
//  Created by Hugo Sevilla Gómez Llanos on 30/12/24.
//

import SwiftUI

struct LinkButtonView: View {
    var title: String
    var icon: String?
    var url: URL

    var body: some View {
        Button(action: {
            openURL(url)
        }) {
            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                }
                Text(title)
            }
        }
        .buttonStyle(BorderlessButtonStyle())
        .foregroundColor(.blue)
    }

    private func openURL(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
