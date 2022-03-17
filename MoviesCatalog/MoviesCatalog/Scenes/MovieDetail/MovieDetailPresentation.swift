//
//  MovieDetailPresentation.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import Foundation

public final class MovieDetailPresentation: NSObject {
    public let id: Int
    public let title: String
    public let overview: String
    public let posterPath: String
    public let releaseDate: String
    public let image: String
    public let voteAverage: String
    
    public init(id: Int, title: String, overview: String, posterPath: String, releaseDate: String, image: String, voteAverage: String) {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.image = image
        self.voteAverage = voteAverage
        super.init()
    }
}

extension MovieDetailPresentation {
   public override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? MovieDetailPresentation else {return false}
    return other.id == self.id && other.overview == self.overview && other.posterPath == self.posterPath && other.releaseDate == self.releaseDate && other.image == self.image && other.voteAverage == self.voteAverage
    }
}

extension MovieDetailPresentation {
    convenience init(movieDetail: MovieDetail) {
        self.init(id: movieDetail.id, title: movieDetail.title, overview: movieDetail.overview, posterPath: movieDetail.posterPath, releaseDate: movieDetail.releaseDate ?? "", image: movieDetail.image, voteAverage: movieDetail.voteAverage)
    }
}

