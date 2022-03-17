//
//  WatchListBuilder.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import UIKit

public final class WatchListBuilder {
    static func make() -> WatchListViewController {
        let storyboard = UIStoryboard(name: "WatchList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "WatchList") as! WatchListViewController
        viewController.viewModel = WatchListViewModel(service: app.moviesService, serviceCoreDataList: app.serviceCoreData)
        return viewController
    }
}


