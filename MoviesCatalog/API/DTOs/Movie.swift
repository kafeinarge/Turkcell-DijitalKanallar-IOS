//
//  Movie.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 13.03.2022.
//

import Foundation

public struct Movie: Decodable, Equatable {
    public let id: Int
    public let title: String
    public let posterPath: String
    public let releaseDate: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath
        case releaseDate
    }
    
    public var image: String {
        return Constants.baseImageUrl + posterPath
    }
    
}
