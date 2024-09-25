//
//  ApiResponse.swift
//  Recipes
//
//  Created by Miha on 24/09/2024.
//

import Foundation

struct Response: Codable {
    let hits: [Hit]
}

struct Hit: Codable, Hashable {
    let recipe: Recipe
}
