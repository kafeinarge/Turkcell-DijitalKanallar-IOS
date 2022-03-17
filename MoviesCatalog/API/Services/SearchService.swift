//
//  SearchService.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 14.03.2022.
//

import Foundation

public final class SearchService: SearchServiceProtocol  {
    public weak var delegate: SearchServiceDelegate?
    
    public init () {}
    
    public func loadSearch(query: String) {
        let api = API.search(query: query)
        let stringUrl = api.fullUrl
        
        let urlComp =  api.parameters.getComponents(urlString: stringUrl)
        var request = try! URLRequest(url: urlComp.url.unwrap())
        request.allHTTPHeaderFields = api.headers
        request.httpMethod = api.method
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { [weak self] (data, httpResponse, error) in
            guard let self = self else {return}
            
            if let error =  error {
                self.delegate?.resultSearch(result: .failure(Error.networkError(error)))
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(MoviesResponse.self, from: data)
                    self.delegate?.resultSearch(result: .success(response))
                } catch {
                    self.delegate?.resultSearch(result: .failure(Error.serializationError(error)))
                }
            }
        }
        dataTask.resume()
    }
}

