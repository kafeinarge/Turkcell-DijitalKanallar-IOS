//
//  LoginBuilder.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import UIKit

public final class LoginBuilder {
    public static func make() -> LoginViewController {
        let storyboard = UIStoryboard(name: "Login" , bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        viewController.viewModel = LoginViewModel(service: app.loginService)
        return viewController
    }
}
