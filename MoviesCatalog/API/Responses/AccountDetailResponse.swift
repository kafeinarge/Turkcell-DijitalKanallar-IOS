//
//  AccountDetailResponse.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//


import Foundation

public struct AccountDetailResponse: Decodable {
    
    public let result: AccountDetail
    
    public init (result: AccountDetail) {
        self.result = result
    }
    
    public init(from decoder: Decoder) throws {
        let RootValues = try decoder.singleValueContainer()
        self.result = try RootValues.decode(AccountDetail.self)
    }
}

