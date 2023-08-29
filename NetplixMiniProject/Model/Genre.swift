//
//  Genre.swift
//  NetplixMiniProject
//
//  Created by Ferry Julian on 22/08/23.
//

import Foundation

struct genreResponse: Decodable {
    let genre: [Genre]?
    
    internal enum CodingKeys: String, CodingKey {
        case genre = "genres"
    }
}

struct Genre: Decodable {
    let id: Int?
    let name: String?
    
    internal enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    public static var `default`: Genre {
        Genre(id: 1, name: "Default")
    }
}
