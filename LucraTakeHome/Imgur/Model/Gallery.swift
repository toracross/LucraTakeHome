//
//  Gallery.swift
//  LucraTakeHome
//
//  Created by Wellison Pereira on 1/19/24.
//

import Foundation

struct GalleryData: Codable {
    var galleries: [Gallery]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.galleries = try container.decode([Gallery].self, forKey: .galleries)
    }
    
    enum CodingKeys: String, CodingKey {
        case galleries = "data"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.galleries, forKey: .galleries)
    }
}

struct Gallery: Codable, Identifiable {
    let id: String
    let title: String?
    let isAlbum: Bool
    let images: [GalleryImage]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.isAlbum = try container.decode(Bool.self, forKey: .isAlbum)
        self.images = try container.decodeIfPresent([GalleryImage].self, forKey: .images) ?? []
    }
    
    enum CodingKeys: String, CodingKey {
        case id, images, title
        case isAlbum = "is_album"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encode(self.isAlbum, forKey: .isAlbum)
        try container.encode(self.images, forKey: .images)
    }
}

struct GalleryImage: Codable, Identifiable {
    enum MediaType: String, Codable {
        case image
        case video
    }
    
    let id: String
    let link: String
    let type: MediaType
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.link = try container.decode(String.self, forKey: .link)
        
        // Filter for image types. The API can return png, jpeg, etc but prefixes everything with either image or video.
        // Reason for this is AsyncImage cannot load videos so you get endless attempts to load non-image media.
        let type = try container.decode(String.self, forKey: .type)
        self.type = type.contains("image") ? .image : .video
    }
    
    enum CodingKeys: String, CodingKey {
        case id, link, type
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.link, forKey: .link)
        try container.encode(self.type, forKey: .type)
    }
}

