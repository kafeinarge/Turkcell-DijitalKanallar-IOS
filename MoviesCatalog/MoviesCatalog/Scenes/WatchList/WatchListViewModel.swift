//
//  WatchListViewModel.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import Foundation

public final class WatchListViewModel: WatchListViewModelProtocol {
    public weak var delegate: WatchListViewModelDelegate?
    private var service: WatchListMoviesServiceProtocol!
    private var serviceCoreDataList: WatchListCoreDataProtocol!
    
    private var movies: [Movie] = []
    
    init(service: WatchListMoviesServiceProtocol, serviceCoreDataList: WatchListCoreDataProtocol) {
        self.service = service
        self.service.delegate = self
        self.serviceCoreDataList = serviceCoreDataList
        self.serviceCoreDataList.delegateWatchList = self
    }
    
    public func loadMovies() {
        notify(.updateTitle("Search"))
        notify(.setLoading(true))
        serviceCoreDataList.fetchList(protocolType: .watchList)
        //service.loadMovies()
    }
}

extension WatchListViewModel: WatchListMoviesServiceDelegate {
    public func resultMovies(result: Result<MoviesResponse>) {
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

extension WatchListViewModel: WatchListCoreDataDelegate {
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


extension WatchListViewModel {
    private func notify(_ output: WatchListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}

