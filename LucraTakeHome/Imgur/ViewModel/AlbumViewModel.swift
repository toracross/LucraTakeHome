//
//  AlbumViewModel.swift
//  LucraTakeHome
//
//  Created by Wellison Pereira on 1/19/24.
//

import Foundation

protocol AlbumViewModelProtocol: ObservableObject {
    /// The title of the album to display.
    var albumTitle: String? { get }
    /// The images that belong to the album.
    var albumImages: [GalleryImage] { get }
}

class AlbumViewModel: AlbumViewModelProtocol {
    var albumTitle: String?
    var albumImages: [GalleryImage]
    
    init(albumTitle: String?, albumImages: [GalleryImage]) {
        self.albumTitle = albumTitle
        self.albumImages = albumImages
    }
}
