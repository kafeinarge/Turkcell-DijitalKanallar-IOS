//
//  LogoutResponse.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 14.03.2022.
//

import Foundation

public struct DefaultResponse: Decodable {
    
    public let result: Response
    
    public init (result: Response) {
        self.result = result
    }
    
    public init(from decoder: Decoder) throws {
        let RootValues = try decoder.singleValueContainer()
        self.result = try RootValues.decode(Response.self)
    }
}
