//
//  FavoritedMoviesService.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import Foundation

public final class FavoritedMoviesService: FavoritedMoviesServiceProtocol  {
    public weak var delegate: FavoritedMoviesServiceDelegate?
    
    public init () {}
    
    public func loadFavoritedMovies() {
        let api = API.favoriteMovies
        let stringUrl = api.fullUrl
        
        print(api.parameters)
        let urlComp =  api.parameters.getComponents(urlString: stringUrl)
        var request = try! URLRequest(url: urlComp.url.unwrap())
        request.httpMethod = api.method
        request.allHTTPHeaderFields = api.headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { [weak self] (data, httpResponse, error) in
            guard let self = self else {return}
            
            if let error =  error {
                self.delegate?.resultFavoritedMovies(result: .failure(Error.networkError(error)))
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(MoviesResponse.self, from: data)
                    self.delegate?.resultFavoritedMovies(result: .success(response))
                } catch {
                    self.delegate?.resultFavoritedMovies(result: .failure(Error.serializationError(error)))
                }
            }
        }
        dataTask.resume()
    }
}

