//
//  MoviesResponse.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 13.03.2022.
//

import Foundation

public struct MoviesResponse: Decodable {
    
    public let result: [Movie]
    
    public init(result: [Movie]) {
        self.result = result
    }
    
    private enum ResultCodingKeys: String, CodingKey {
        case movieList
    }
    
    public init(from decoder: Decoder) throws {
        let rootValues = try decoder.container(keyedBy: ResultCodingKeys.self)
        self.result = try rootValues.decode([Movie].self, forKey: .movieList)
    }
}
