//
//  MovieDetail.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 13.03.2022.
//

import Foundation

public struct MovieDetail: Decodable, Equatable {
    public let id: Int
    public let title: String
    public let overview: String
    public let posterPath: String
    public let releaseDate: String?
    public let voteAverage: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath
        case releaseDate
        case voteAverage
    }
    
    public var image: String {
        return Constants.baseImageUrl + posterPath
    }
}

