//
//  LogoutService.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 14.03.2022.
//

import Foundation

public final class LogoutService: LogoutServiceProtocol  {
    public weak var delegate: LogoutServiceDelegate?
    
    public init () {}
    
    public func loadLogout() {
        let api = API.logout
        let stringUrl = api.fullUrl
        
        var request = try! URLRequest(url: URL(string: stringUrl).unwrap())
        request.httpBody = api.parameters.getJSONData()
        request.httpMethod = api.method
        request.allHTTPHeaderFields = api.headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { [weak self] (data, httpResponse, error) in
            guard let self = self else {return}
            
            if let error =  error {
                self.delegate?.resultLogout(result: .failure(Error.networkError(error)))
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(DefaultResponse.self, from: data)
                    self.delegate?.resultLogout(result: .success(response))
                } catch {
                    self.delegate?.resultLogout(result: .failure(Error.serializationError(error)))
                }
            }
        }
        dataTask.resume()
    }
}
