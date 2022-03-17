//
//  SearchContracts.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import Foundation

public protocol SearchViewModelProtocol: AnyObject {
    var delegate: SearchViewModelDelegate? { get set }
    func load()
    func search(text: String)
    func selectMovie(at index: Int)
}

public enum SearchViewModelOutput: Equatable {
    case updateTitle(String)
    case setLoading(Bool)
    case showMovies([MoviePresentation])
    case showError(Error)
}

public enum SearchViewModelRoute {
    case movieDetail(Int)
}

public protocol SearchViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: SearchViewModelOutput)
    func navigate(to route: SearchViewModelRoute)
}

