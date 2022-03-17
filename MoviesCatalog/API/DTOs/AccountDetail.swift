//
//  AccountDetail.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//


import Foundation

public struct AccountDetail: Decodable, Equatable {
    public var accountId: Int
    public let name: String?
    public let userName: String?
    
    private enum CodingKeys: String, CodingKey {
        case accountId
        case name
        case userName
    }
}
