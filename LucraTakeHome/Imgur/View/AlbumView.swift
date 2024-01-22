//
//  AlbumView.swift
//  LucraTakeHome
//
//  Created by Wellison Pereira on 1/19/24.
//

import SwiftUI
import CachedAsyncImage

struct AlbumView<ViewModel>: View where ViewModel: AlbumViewModelProtocol {
    @State private var isFullScreen = false
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            albumView
        }
        .navigationTitle(viewModel.albumTitle ?? "Album")
    }
    
    var albumView: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 20) {
                ForEach(viewModel.albumImages) { album in
                    NavigationLink(destination: FullScreenImageView(imageUrl: album.link)) {
                        CardView(imageUrl: album.link, scale: 0.5)
                            .frame(height: 220)
                    }
                }
            }
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    AlbumView(viewModel: AlbumViewModel(albumTitle: "Test", albumImages: []))
}


