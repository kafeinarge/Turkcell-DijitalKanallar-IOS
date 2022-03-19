//
//  AppContainer.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 14.03.2022.
//

import Foundation

let app = AppContainer()
public final class AppContainer {
    let router = AppRouter()
    let loginService = LoginService()
    let searchService = SearchService()
    let moviesService = WatchListMoviesService()
    let movieDetailService = MovieDetailService()
    let accountService = AccountDetailService()
    let favoriteMoviesService = FavoritedMoviesService()
    let moviesAddRemoveService = MoviesRemoveAddService()
    let favoritedAddRemoveService = FavoritedRemoveAddService()
    let logoutManager = LogoutManager(service: LogoutService())
    let serviceCoreData = CoreDataManager()
    let networkListener = NetworkListener()
    let imageCache = NSCache<AnyObject, AnyObject>()
}
