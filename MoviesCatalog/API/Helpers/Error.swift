//
//  Error.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 13.03.2022.
//

import Foundation

public enum Error: Swift.Error, Equatable {
    public static func == (lhs: Error, rhs: Error) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
    case serializationError(_ internal: Swift.Error)
    case networkError(_ internal: Swift.Error)
}
