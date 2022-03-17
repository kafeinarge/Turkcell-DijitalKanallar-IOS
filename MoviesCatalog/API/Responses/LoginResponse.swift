//
//  LoginResponse.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 14.03.2022.
//

import Foundation

public struct LoginResponse: Decodable {
    
    public let result: Login
    
    public init (result: Login) {
        self.result = result
    }
    
    public init(from decoder: Decoder) throws {
        let RootValues = try decoder.singleValueContainer()
        self.result = try RootValues.decode(Login.self)
    }
}

