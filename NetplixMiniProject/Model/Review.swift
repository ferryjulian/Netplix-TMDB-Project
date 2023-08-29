//
//  Review.swift
//  NetplixMiniProject
//
//  Created by Ferry Julian on 22/08/23.
//

import Foundation

public struct MovieReviewResponse: Decodable {
    public let reviews: [MovieReview]
    
    internal enum CodingKeys: String, CodingKey {
        case reviews = "results"
    }
}

public struct MovieReview: Decodable {
    public let id: String?
    public let author: String?
    public let content: String?
    public let avatarPath: String?
    public let authorDetails: AuthorDetails
    
    internal enum CodingKeys: String, CodingKey {
        case id = "id"
        case author = "author"
        case content = "content"
        case avatarPath = "avatar_path"
        case authorDetails = "author_details"
    }
}

public struct AuthorDetails: Decodable {
    public let avatarPath: String?
    
    public var avatarPathUrl: String? {
        APICall.imageAvatarUrl + (avatarPath ?? "")
    }
    
    
    internal enum CodingKeys: String, CodingKey {
        case avatarPath = "avatar_path"
    }
}
