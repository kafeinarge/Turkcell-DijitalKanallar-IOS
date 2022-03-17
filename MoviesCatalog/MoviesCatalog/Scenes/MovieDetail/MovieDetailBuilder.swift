//
//  MovieDetailBuilder.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 16.03.2022.
//

import UIKit

public final class MovieDetailBuilder {
    static func make(id: Int) -> MovieDetailViewController {
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetail") as! MovieDetailViewController
        viewController.movieId = id
        viewController.viewModel = MovieDetailViewModel(service: app.movieDetailService, serviceWathcListAddRemove: app.moviesAddRemoveService, serviceFavoritedAddRemove: app.favoritedAddRemoveService, serviceCoreDataSearch: app.serviceCoreData)
        return viewController
    }
}


