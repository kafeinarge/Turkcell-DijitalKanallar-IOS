//
//  FavoriteContracts.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import Foundation

public protocol FavoriteListViewModelProtocol: AnyObject {
    var delegate: FavoriteListViewModelDelegate? { get set }
    func loadMovies()
}

public enum FavoriteListViewModelOutput: Equatable {
    case updateTitle(String)
    case setLoading(Bool)
    case showMovies([MoviePresentation])
    case showError(Error)
}

public protocol FavoriteListViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: FavoriteListViewModelOutput)
}


