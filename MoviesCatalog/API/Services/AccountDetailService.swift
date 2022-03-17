//
//  AccountDetailService.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import Foundation

public final class AccountDetailService: AccountDetailServiceProtocol  {
    public weak var delegate: AccountDetailServiceDelegate?
    
    public init () {}
    
    public func loadAccountDetail() {
        let api = API.accountDetail
        let stringUrl = api.fullUrl
        
        let urlComp =  api.parameters.getComponents(urlString: stringUrl)
        var request = try! URLRequest(url: urlComp.url.unwrap())
        request.httpMethod = api.method
        request.allHTTPHeaderFields = api.headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { [weak self] (data, httpResponse, error) in
            guard let self = self else {return}
            
            if let error =  error {
                self.delegate?.resultAccountDetail(result: .failure(Error.networkError(error)))
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(AccountDetailResponse.self, from: data)
                    self.delegate?.resultAccountDetail(result: .success(response))
                } catch {
                    self.delegate?.resultAccountDetail(result: .failure(Error.serializationError(error)))
                }
            }
        }
        dataTask.resume()
    }
}
