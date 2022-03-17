//
//  LoginService.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 14.03.2022.
//

import Foundation

public final class LoginService: LoginServiceProtocol  {
    public weak var delegate: LoginServiceDelegate?
    
    public init () {}
    
    public func loadLogin(email: String, password: String) {
        let api = API.login(email: email, password: password)
        let stringUrl = api.fullUrl
        
        var request = try! URLRequest(url: URL(string: stringUrl).unwrap())
        request.httpBody = api.parameters.getJSONData()
        request.httpMethod = api.method
        request.allHTTPHeaderFields = api.headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { [weak self] (data, httpResponse, error) in
            guard let self = self else {return}
            
            if let error =  error {
                self.delegate?.resultLogin(result: .failure(Error.networkError(error)))
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                    self.delegate?.resultLogin(result: .success(response))
                } catch {
                    self.delegate?.resultLogin(result: .failure(Error.serializationError(error)))
                }
            }
        }
        dataTask.resume()
    }
}

