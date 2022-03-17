//
//  MoviePresentation.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import Foundation

public final class MoviePresentation: NSObject {
    public let id: Int
    public let title: String
    public let posterPath: String?
    public let releaseDate: String?
    public let image: String?
    public let imageData: Data?
    
    public init(id: Int, title: String, posterPath: String?, releaseDate: String?, image: String?, imageData: Data?) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.image = image
        self.imageData = imageData
        super.init()
    }
}

extension MoviePresentation {
   public override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? MoviePresentation else {return false}
        return other.id == self.id && other.title == self.title && other.posterPath == self.posterPath && other.releaseDate == self.releaseDate && other.image == self.image
    }
}

extension MoviePresentation {
    convenience init(movie: Movie) {
        self.init(id: movie.id, title: movie.title, posterPath: movie.posterPath, releaseDate: movie.releaseDate, image: movie.image, imageData: nil)
    }
}

extension MoviePresentation {
    convenience init(movie: MovieCore) {
        self.init(id: movie.id, title: movie.title, posterPath: nil, releaseDate: nil, image: nil, imageData: movie.image)
    }
}
