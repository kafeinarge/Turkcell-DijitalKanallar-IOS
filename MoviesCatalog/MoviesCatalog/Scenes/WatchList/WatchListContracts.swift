//
//  WatchListContracts.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import Foundation

public protocol WatchListViewModelProtocol: AnyObject {
    var delegate: WatchListViewModelDelegate? { get set }
    func loadMovies()
}

public enum WatchListViewModelOutput: Equatable {
    case updateTitle(String)
    case setLoading(Bool)
    case showMovies([MoviePresentation])
    case showError(Error)
}

public protocol WatchListViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: WatchListViewModelOutput)
}


