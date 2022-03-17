//
//  ServiceContracts.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 13.03.2022.
//

import Foundation


/// LOGIN
public protocol LoginServiceProtocol: AnyObject {
    var delegate: LoginServiceDelegate? { set get }
    func loadLogin(email: String, password: String)
}

public protocol LoginServiceDelegate: AnyObject {
    func resultLogin(result: Result<LoginResponse>)
}

/// LOGOUT
public protocol LogoutServiceProtocol: AnyObject {
    var delegate:LogoutServiceDelegate? { set get }
    func loadLogout()
}

public protocol LogoutServiceDelegate: AnyObject {
    func resultLogout(result: Result<DefaultResponse>)
}


/// WATCHLIST
public protocol WatchListMoviesServiceProtocol: AnyObject {
    var delegate: WatchListMoviesServiceDelegate? { set get }
    func loadMovies()
}

public protocol WatchListMoviesServiceDelegate: AnyObject {
    func resultMovies(result: Result<MoviesResponse>)
}

/// SEARCH
public protocol SearchServiceProtocol: AnyObject {
    var delegate: SearchServiceDelegate? { set get }
    func loadSearch(query: String)
}

public protocol SearchServiceDelegate: AnyObject {
    func resultSearch(result: Result<MoviesResponse>)
}

/// MOVIE DETAIL
public protocol MovieDetailServiceProtocol: AnyObject {
    var delegate: MovieDetailServiceDelegate? { set get }
    func loadMovieDetail(id: Int)
}

public protocol MovieDetailServiceDelegate: AnyObject {
    func resultMovieDetail(result: Result<MovieDetailResponse>)
}

/// FAVORİTED MOVIE LIST
public protocol FavoritedMoviesServiceProtocol: AnyObject {
    var delegate: FavoritedMoviesServiceDelegate? { set get }
    func loadFavoritedMovies()
}

public protocol FavoritedMoviesServiceDelegate: AnyObject {
    func resultFavoritedMovies(result: Result<MoviesResponse>)
}

/// FAVORİTED REMOVE ADD
public protocol FavoritedRemoveAddServiceProtocol: AnyObject {
    var delegate: FavoritedRemoveAddServiceDelegate? { set get }
    func loadFavoritedRemoveAdd(mediaId: Int, favorite: Bool)
}

public protocol FavoritedRemoveAddServiceDelegate: AnyObject {
    func resultFavoritedRemoveAdd(result: Result<DefaultResponse>)
}

/// MOVIE LIST REMOVE ADD
public protocol MoviesRemoveAddServiceProtocol: AnyObject {
    var delegate: MoviesRemoveAddServiceDelegate? { set get }
    func loadMoviesRemoveAdd(mediaId: Int, watchList: Bool)
}

public protocol MoviesRemoveAddServiceDelegate: AnyObject {
    func resultMoviesRemoveAdd(result: Result<DefaultResponse>)
}

/// ACCOUNT  DETAIL
public protocol AccountDetailServiceProtocol: AnyObject {
    var delegate: AccountDetailServiceDelegate? { set get }
    func loadAccountDetail()
}

public protocol AccountDetailServiceDelegate: AnyObject {
    func resultAccountDetail(result: Result<AccountDetailResponse>)
}
