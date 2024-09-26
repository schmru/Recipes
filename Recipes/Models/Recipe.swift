//
//  Recipe.swift
//  Recipe
//
//  Created by Miha on 24/09/2024.
//

import Foundation

struct Recipe: Codable, Hashable {
    let label: String
    let images: ThumbnailImage
    let calories: Float
    
    static func getMockRecepie() -> Recipe {
        let thumbnail = Thumbnail(url: "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&webp=true&resize=600,545")
        let image = ThumbnailImage(thumbnail: thumbnail)
        return .init(label: "Recipe name",
                     images: image,
                     calories: 10000.00)
    }
}

struct ThumbnailImage: Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        case thumbnail = "THUMBNAIL"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        thumbnail = try values.decode(Thumbnail.self, forKey: .thumbnail)
    }
    
    init(thumbnail: Thumbnail){
        self.thumbnail = thumbnail
    }
    
    let thumbnail: Thumbnail
}

struct Thumbnail: Codable, Hashable {
    let url: String
}
