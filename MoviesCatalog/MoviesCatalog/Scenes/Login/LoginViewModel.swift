//
//  LoginViewModel.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import Foundation

public final class LoginViewModel: LoginViewModelProtocol {
    public weak var delegate: LoginViewModelDelegate?
    private var service: LoginServiceProtocol!
    
    public init (service: LoginServiceProtocol) {
        self.service = service
        self.service.delegate = self
    }
    
    public func load() {
        notify(.updateTitle("The Movie Manager"))
        notify(.setRememberMe)
    }
    
    public func login(email: String, password: String) {
        notify(.setLoading(true))
        service.loadLogin(email: email, password: password)
    }
}

extension LoginViewModel: LoginServiceDelegate {
    public func resultLogin(result: Result<LoginResponse>) {
        notify(.setLoading(false))
        switch result {
        case .success(let response):
            let presentation = LoginPresentation.init(login: response.result)
            Constants.sessionId = response.result.sessionId
            
            guard !presentation.sessionId.isEmpty else {
                delegate?.setWarningLabel("Data is empty")
                return
            }
            
            notify(.showLogin(presentation))
            self.delegate?.navigate(to: .search)
        case .failure(let error):
            delegate?.setWarningLabel(error.localizedDescription)
        }
    }
}

extension LoginViewModel {
    private func notify(_ output: LoginViewModelOutput) {
        self.delegate?.handleViewModelOutput(output)
    }
}
