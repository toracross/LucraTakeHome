//
//  FullScreenImageView.swift
//  LucraTakeHome
//
//  Created by Wellison Pereira on 1/19/24.
//

import SwiftUI

/// Displays an image in full screen.
struct FullScreenImageView: View {
    var imageUrl: String
    @GestureState private var zoom = 1.0

    var body: some View {
        GeometryReader { reader in
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    
                } placeholder: {
                    ProgressView()
                }
                .frame(width: reader.size.width, height: reader.size.height)
                .scaleEffect(zoom)
                .gesture(
                    MagnifyGesture()
                        .updating($zoom) { value, gestureState, transaction in
                            gestureState = value.magnification
                        }
                )
        }
    }
}

#Preview {
    FullScreenImageView(imageUrl: "")
}
