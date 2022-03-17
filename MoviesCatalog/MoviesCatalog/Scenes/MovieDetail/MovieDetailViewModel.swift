//
//  MovieDetailViewModel.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import Foundation

public final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    public weak var delegate: MovieDetailViewModelDelegate?
    private let service: MovieDetailServiceProtocol!
    private let serviceWathcListAddRemove: MoviesRemoveAddServiceProtocol!
    private let serviceFavoritedAddRemove: FavoritedRemoveAddServiceProtocol!
    private let serviceCoreDataSearch: SearchCoreDataProtocol!
    
    private var movieDetail: MovieDetail!
    private var isFavorited: Bool = false
    private var isWatchList: Bool = false
    
    init(service: MovieDetailServiceProtocol, serviceWathcListAddRemove: MoviesRemoveAddServiceProtocol, serviceFavoritedAddRemove: FavoritedRemoveAddServiceProtocol, serviceCoreDataSearch: SearchCoreDataProtocol) {
        self.service = service
        self.serviceWathcListAddRemove = serviceWathcListAddRemove
        self.serviceFavoritedAddRemove = serviceFavoritedAddRemove
        self.serviceCoreDataSearch = serviceCoreDataSearch
        self.service.delegate = self
        self.serviceWathcListAddRemove.delegate = self
        self.serviceFavoritedAddRemove.delegate = self
        self.serviceCoreDataSearch.delegateSearch = self
    }
    
    public func load(id: Int) {
        notify(.setLoading(true))
        isContain(id: id, type: .watchList)
        isContain(id: id, type: .favoriteList)
        service.loadMovieDetail(id: id)
    }
    
    public func addRemove(id: Int, type: ProtocolType, data: Data) {
        notify(.setLoading(true))
        
        let movieCore = MovieCore.init(id: movieDetail.id, title: movieDetail.title, image: data, type: type.rawValue)
        
        switch type {
        case .watchList:
            if isWatchList {
                serviceCoreDataSearch.deleteFavorite(id: id, protocolType: type)
            } else {
                serviceCoreDataSearch.saveFavorite(movie: movieCore, protocolType: type)
            }
            serviceWathcListAddRemove.loadMoviesRemoveAdd(mediaId: id, watchList: isWatchList)
        case .favoriteList:
            if isFavorited {
                serviceCoreDataSearch.deleteFavorite(id: id, protocolType: type)
            } else {
                serviceCoreDataSearch.saveFavorite(movie: movieCore, protocolType: type)
            }
            serviceFavoritedAddRemove.loadFavoritedRemoveAdd(mediaId: id, favorite: isFavorited)
        }
    }
    
    public func isContain(id: Int, type: ProtocolType) {
        serviceCoreDataSearch.isContainFavorite(id: id, protocolType: type)
    }
}


extension MovieDetailViewModel: MovieDetailServiceDelegate,
                            MoviesRemoveAddServiceDelegate,
                            FavoritedRemoveAddServiceDelegate {
    public func resultMoviesRemoveAdd(result: Result<DefaultResponse>) {
        notify(.setLoading(false))
        switch result {
        case .success(let response):
            print(response.result.responseCode ?? "başarılı")
        case .failure(let error):
            print(error)
        }
    }
    
    public func resultFavoritedRemoveAdd(result: Result<DefaultResponse>) {
        notify(.setLoading(false))
        switch result {
        case .success(let response):
            print(response.result.responseCode ?? "başarılı")
        case .failure(let error):
            print(error)
        }
    }
    
    public func resultMovieDetail(result: Result<MovieDetailResponse>) {
        switch result {
        case .success(let response):
            movieDetail = response.result
            let presentation = MovieDetailPresentation.init(movieDetail: response.result)
            notify(.setLoading(false))
            notify(.updateTitle(movieDetail.title))
            notify(.showMovieDetail(presentation))
        case .failure(let error):
            notify(.showError(error))
        }
    }
}

extension MovieDetailViewModel: SearchCoreDataDelegate {
    public func resultSave(result: Result<[ProtocolType:Bool]>) {
        switch result {
        case .success(let dictionary):
            if dictionary.keys.first == .favoriteList {
                isFavorited = dictionary.first!.value as Bool
            } else if dictionary.keys.first == .watchList {
                isWatchList = dictionary.first!.value as Bool
            }
            notify(.isContain(isWatchList, isFavorited))
        case .failure(let error):
            notify(.showError(error))
        }
    }
    
    public func resultDelete(result: Result<[ProtocolType:Bool]>) {
        switch result {
        case .success(let dictionary):
            if dictionary.keys.first == .favoriteList {
                isFavorited = !(dictionary.first!.value as Bool)
            } else if dictionary.keys.first == .watchList {
                isWatchList = !(dictionary.first!.value as Bool)
            }
            notify(.isContain(isWatchList, isFavorited))
        case .failure(let error):
            notify(.showError(error))
        }
    }
    
    public func resultIsContain(result: Result<[ProtocolType:Bool]>) {
        switch result {
        case .success(let dictionary):
            if dictionary.keys.first == .favoriteList {
                isFavorited = dictionary.first!.value as Bool
            } else if dictionary.keys.first == .watchList {
                isWatchList = dictionary.first!.value as Bool
            }
            notify(.isContain(isWatchList, isFavorited))
        case .failure(let error):
            notify(.showError(error))
        }
    }
}

extension MovieDetailViewModel {
    private func notify(_ output: MovieDetailViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}

