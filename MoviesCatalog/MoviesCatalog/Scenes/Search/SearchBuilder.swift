//
//  SearchBuilder.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import UIKit

public final class SearchBuilder {
    static func make() -> SearchViewController {
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Search") as! SearchViewController
        viewController.viewModel = SearchViewModel(service: app.searchService, accountService: app.accountService)
        return viewController
    }
}

