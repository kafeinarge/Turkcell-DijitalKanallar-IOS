//
//  MovieDetailResponse.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 13.03.2022.
//

import Foundation

public struct MovieDetailResponse: Decodable {
    
    public let result: MovieDetail
    
    public init(result: MovieDetail) {
        self.result = result
    }
    
    private enum ResultCodingKeys: String, CodingKey {
        case movieDetailType
    }
    
    public init(from decoder: Decoder) throws {
        let rootValues = try decoder.container(keyedBy: ResultCodingKeys.self)
        self.result = try rootValues.decode(MovieDetail.self, forKey: .movieDetailType)
    }
}
