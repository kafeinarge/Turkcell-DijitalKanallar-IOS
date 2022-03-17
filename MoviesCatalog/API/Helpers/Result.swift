//
//  Result.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 13.03.2022.
//

import Foundation

public enum Result<T> {
    case success(T)
    case failure(Error)
}
