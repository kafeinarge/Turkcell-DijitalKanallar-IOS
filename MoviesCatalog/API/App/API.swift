//
//  API.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 13.03.2022.
//

import Foundation

public enum API {
    //Methods
    case login(email: String, password: String)
    case logout
    case movieDetail(movieId: Int)
    case movieImage(filePath: String)
    case search(query: String)
    case accountDetail
    case favoriteAddRemove(mediaId: Int, favorite: Bool)
    case favoriteMovies
    case moviesAddRemove(mediaId: Int, watchList: Bool)
    case watchListMovies
}

extension API {
    private var baseUrl: String {
        return "http://46.101.105.123:8080"
    }
    
    private var path: String {
        switch self {
        case .login:
            return "/user/login"
        case .logout:
            return "/user/logout"
        case .movieDetail:
            return "/movie/detail"
        case .movieImage:
            return "/movie/imagine"
        case .search:
            return "/movie/search"
        case .accountDetail:
            return "/account/detail"
        case .favoriteAddRemove:
            return "/account/favorite/add_remove"
        case .favoriteMovies:
            return "/account/favorite/movies"
        case .moviesAddRemove:
            return "/account/watch_list/add_remove"
        case .watchListMovies:
            return "/account/watch_list/movies"
        }
    }
    
    public var fullUrl: String {
        switch self {
        default:
            return baseUrl + path
        }
    }
    
    public var method: String {
        switch self {
        case .login,
             .logout,
             .favoriteAddRemove,
             .moviesAddRemove:
            return "POST"
        case .movieImage,
             .accountDetail,
             .favoriteMovies,
             .movieDetail,
             .search,
             .watchListMovies:
            return "GET"
        }
    }
    
    public var parameters: [String: Any] {
        switch self {
        case .login(email: let email, password: let password):
            return ["userName": email, "password": password]
        case .logout:
            return ["sessionId": Constants.sessionId]
        case .movieDetail(movieId: let movieId):
            return ["movie_id": "\(movieId)"]
        case .movieImage(filePath: let filePath):
            return ["file_path": filePath]
        case .search(query: let query):
            return ["query": query]
        case .accountDetail:
            return ["session_id": Constants.sessionId]
        case .favoriteAddRemove(mediaId: let mediaId, favorite: let favorite):
            return ["account_id": "\(Constants.accountId)", "favorite": "\(favorite)","mediaId": "\(mediaId)", "session_id": "\(Constants.sessionId)"]
        case .favoriteMovies:
            return ["session_id": Constants.sessionId, "account_id": "\(Constants.accountId)"]
        case .moviesAddRemove(mediaId: let mediaId, watchList: let watchList):
            return ["session_id": "\(Constants.sessionId)", "account_id": "\(Constants.accountId)", "mediaId": "\(mediaId)", "watchList": "\(watchList)"]
        case .watchListMovies:
            return ["session_id": Constants.sessionId, "account_id": "\(Constants.accountId)"]
        }
    }
    
    public var headers: [String : String] {
        switch self {
        default:
            return ["Content-Type" : "application/json"]
        }
    }
}

