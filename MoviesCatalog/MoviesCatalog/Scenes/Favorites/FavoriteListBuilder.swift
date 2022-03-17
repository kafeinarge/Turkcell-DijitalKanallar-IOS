//
//  FavoriteListBuilder.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import UIKit

public final class FavoriteListBuilder {
    static func make() -> FavoriteListViewController {
        let storyboard = UIStoryboard(name: "FavoriteList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FavoriteList") as! FavoriteListViewController
        viewController.viewModel = FavoriteListViewModel(service: app.favoriteMoviesService, serviceCoreDataList: app.serviceCoreData)
        return viewController
    }
}



