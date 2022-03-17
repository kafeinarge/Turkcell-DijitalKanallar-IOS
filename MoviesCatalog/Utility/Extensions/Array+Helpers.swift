//
//  Array+Helpers.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 13.03.2022.
//

import Foundation

public extension Array {
    
    struct IndexOutOfBoundsError: Swift.Error { }
    
    func element(at index: Int) throws -> Element {
        guard index >= 0 && index < self.count else {
            throw IndexOutOfBoundsError()
        }
        return self[index]
    }
    
    subscript (safe index: Index) -> Element? {
        0 <= index && index < count ? self[index] : nil
    }
}

