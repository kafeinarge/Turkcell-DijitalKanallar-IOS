//
//  AppRouter.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 14.03.2022.
//

import UIKit

final class AppRouter{
    
    let window: UIWindow
    
    init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    func start() {
        DispatchQueue.main.async {
            let rootViewController = UINavigationController(rootViewController: self.startWithLogin())
            self.window.rootViewController = rootViewController
            self.window.makeKeyAndVisible()
        }
    }
}

extension AppRouter {
    func startWithLogin() -> UIViewController {
        return LoginBuilder.make()
    }
    
    func startWithTabBar() {
        self.window.rootViewController?.removeFromParent()
        let tabbarController = UITabBarController()
        tabbarController.viewControllers = getViewControllers().map{ UINavigationController(rootViewController: $0)}
        self.window.rootViewController = tabbarController
        self.window.makeKeyAndVisible()
    }
    
    func getViewControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()
        
        //Tabbar Item 1 Search
        let tabbarItemSearch = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
       
        let viewControllerSearch = SearchBuilder.make()
        addNavigationItemBtn(viewController: viewControllerSearch)
        viewControllerSearch.tabBarItem = tabbarItemSearch
        viewControllers.append(viewControllerSearch)
        
        //Tabbar Item 2 WatchList
        let tabbarItemWatchList = UITabBarItem(title: "WatchList", image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.bullet"))
        
        let viewControllerWatchList = WatchListBuilder.make()
        addNavigationItemBtn(viewController: viewControllerWatchList)
        viewControllerWatchList.tabBarItem = tabbarItemWatchList
        viewControllers.append(viewControllerWatchList)
        
        //Tabbar Item 3 FavoriteList
        let tabbarItemFavoriteList = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), selectedImage: UIImage(systemName: "heart.fill"))
        
        let viewControllerFavoriteList = FavoriteListBuilder.make()
        addNavigationItemBtn(viewController: viewControllerFavoriteList)
        viewControllerFavoriteList.tabBarItem = tabbarItemFavoriteList
        viewControllers.append(viewControllerFavoriteList)
        return viewControllers
    }
}


extension AppRouter {
    func addNavigationItemBtn(viewController: UIViewController){
        let item = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.backward"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(logoutAction))
        viewController.navigationItem.setLeftBarButton(item, animated: false)
    }

    @objc func logoutAction(){
        app.logoutManager.logout()
    }
}
