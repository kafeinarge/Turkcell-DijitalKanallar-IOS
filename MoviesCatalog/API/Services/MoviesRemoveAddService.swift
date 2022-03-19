//
//  MoviesRemoveAddService.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import Foundation

public final class MoviesRemoveAddService: MoviesRemoveAddServiceProtocol  {
    public weak var delegate: MoviesRemoveAddServiceDelegate?
    
    public init () {}
    
    public func loadMoviesRemoveAdd(mediaId: Int, watchList: Bool){
        let api = API.moviesAddRemove(mediaId: mediaId, watchList: watchList)
        let stringUrl = api.fullUrl
        
        let urlComp =  api.parameters.getComponents(urlString: stringUrl)
        var request = try! URLRequest(url: urlComp.url.unwrap())
        request.httpMethod = api.method
        request.allHTTPHeaderFields = api.headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { [weak self] (data, httpResponse, error) in
            guard let self = self else {return}
            
            if let error =  error {
                self.delegate?.resultMoviesRemoveAdd(result: .failure(Error.networkError(error)))
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(DefaultResponse.self, from: data)
                    self.delegate?.resultMoviesRemoveAdd(result: .success(response))
                } catch {
                    self.delegate?.resultMoviesRemoveAdd(result: .failure(Error.serializationError(error)))
                }
            }
        }
        dataTask.resume()
    }
}

