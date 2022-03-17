//
//  FavoriteListViewModel.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import Foundation

public final class FavoriteListViewModel: FavoriteListViewModelProtocol {
    public weak var delegate: FavoriteListViewModelDelegate?
    private var service: FavoritedMoviesServiceProtocol!
    private var serviceCoreDataList: ListCoreDataProtocol!
    
    private var movies: [Movie] = []
    
    init(service: FavoritedMoviesServiceProtocol, serviceCoreDataList: ListCoreDataProtocol) {
        self.service = service
        self.serviceCoreDataList = serviceCoreDataList
        self.service.delegate = self
        self.serviceCoreDataList.delegateList = self
    }
    
    public func loadMovies() {
        notify(.updateTitle("Favorites"))
        notify(.setLoading(true))
        serviceCoreDataList.fetchList(protocolType: .favoriteList)
        //service.loadFavoritedMovies()
    }
}

extension FavoriteListViewModel: FavoritedMoviesServiceDelegate {
    public func resultFavoritedMovies(result: Result<MoviesResponse>) {
        notify(.setLoading(false))
        switch result {
        case .success(let response):
            movies.removeAll()
            movies = response.result
            let presentation = response.result.map{ MoviePresentation.init(movie: $0) }
            notify(.showMovies(presentation))
        case .failure(let error):
            notify(.showError(error))
        }
    }
}

extension FavoriteListViewModel: ListCoreDataDelegate {
    public func resultFetch(result: Result<[MovieCore]>) {
        notify(.setLoading(false))
        switch result {
        case .success(let response):
            movies.removeAll()
            let presentation = response.map {MoviePresentation.init(movie: $0)}
            notify(.showMovies(presentation))
        case .failure(let error):
            print(error)
        }
    }
}

extension FavoriteListViewModel {
    private func notify(_ output: FavoriteListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}


