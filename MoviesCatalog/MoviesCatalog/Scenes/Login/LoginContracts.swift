//
//  LoginContracts.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import Foundation

public protocol LoginViewModelProtocol: AnyObject {
    var delegate: LoginViewModelDelegate? { get set }
    func load()
    func login(email: String, password: String)
}

public enum LoginViewModelOutput: Equatable {
    case updateTitle(String)
    case setRememberMe
    case setLoading(Bool)
    case showLogin(LoginPresentation)
}

public enum LoginViewModelRoute {
    case search
}

public protocol LoginViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: LoginViewModelOutput)
    func navigate(to route: LoginViewModelRoute)
    func setWarningLabel(_ text: String?)
}

