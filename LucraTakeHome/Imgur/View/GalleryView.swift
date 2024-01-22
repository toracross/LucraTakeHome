//
//  GalleryView.swift
//  LucraTakeHome
//
//  Created by Wellison Pereira on 1/19/24.
//

import SwiftUI

struct GalleryView<ViewModel>: View where ViewModel: GalleryViewModelProtocol {
    
    @ObservedObject var viewModel: ViewModel
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                searchView
                galleryView
            }
        }.navigationTitle("Gallery View")
    }
    
    var searchView: some View {
        TextField(
            "Search Criteria",
            text: $searchText,
            onCommit: {
                Task {
                    await viewModel.fetchGalleries(searchText)
                }
            }
        )
        .textFieldStyle(.roundedBorder)
        .padding(.horizontal, 20)
    }
    
    var galleryView: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 20) {
                ForEach(viewModel.galleries) { gallery in
                    NavigationLink(destination: AlbumView(viewModel: AlbumViewModel(albumTitle: gallery.title, albumImages: gallery.images))) {
                        CardView(imageUrl: viewModel.getFirstImageURL(from: gallery) ?? "", scale: 0.3)
                            .frame(height: 220)
                    }
                }
            }
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    GalleryView(viewModel: GalleryViewModel())
}

