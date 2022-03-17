//
//  Response.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 14.03.2022.
//

import Foundation

public struct Response: Decodable, Equatable {
    public let responseCode: Int?
    public let responseDesc: String?
    
    private enum CodingKeys: String, CodingKey {
        case responseCode
        case responseDesc
    }
}
