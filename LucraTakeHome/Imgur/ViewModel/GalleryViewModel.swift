//
//  GalleryViewModel.swift
//  LucraTakeHome
//
//  Created by Wellison Pereira on 1/19/24.
//

import Foundation

protocol GalleryViewModelProtocol: ObservableObject {
    /// The list of available galleries.
    var galleries: [Gallery] { get }
    /// Grabs the first image URL from the list of images in the specified Gallery.
    func getFirstImageURL(from gallery: Gallery) -> String?
    /// Performs a network request to fetch a list of galleries from the provided search term.
    func fetchGalleries(_ searchTerm: String) async
}

class GalleryViewModel: GalleryViewModelProtocol {
    
    private let service = Service.shared
    
    @Published var galleries: [Gallery] = []
    
    func fetchGalleries(_ searchTerm: String) async {
        do {
            if let galleryData: GalleryData = try await service.fetchData(from: .gallery(searchTerm: searchTerm)) {
                DispatchQueue.main.async {
                    // Filter out galleries where the image content is of type video. The image view cannot render videos.
                    self.galleries = galleryData.galleries.filter({ $0.images.contains(where: { $0.type != .video }) })
                }
            }
        } catch {
            print(String(describing: error))
        }
    }
    
    func getFirstImageURL(from gallery: Gallery) -> String? {
        return gallery.images.filter({ $0.type == .image }).first?.link
    }
}
