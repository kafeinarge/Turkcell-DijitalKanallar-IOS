//
//  MovieDetailService.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 13.03.2022.
//

import Foundation

public final class MovieDetailService: MovieDetailServiceProtocol  {
    public weak var delegate: MovieDetailServiceDelegate?
    
    public init () {}
    
    public func loadMovieDetail(id: Int) {
        let api = API.movieDetail(movieId: id)
        let stringUrl = api.fullUrl
        
        let urlComp =  api.parameters.getComponents(urlString: stringUrl)
        var request = try! URLRequest(url: urlComp.url.unwrap())
        request.httpMethod = api.method
        request.allHTTPHeaderFields = api.headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { [weak self] (data, httpResponse, error) in
            guard let self = self else {return}
            
            if let error =  error {
                self.delegate?.resultMovieDetail(result: .failure(Error.networkError(error)))
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(MovieDetailResponse.self, from: data)
                    self.delegate?.resultMovieDetail(result: .success(response))
                } catch {
                    self.delegate?.resultMovieDetail(result: .failure(Error.serializationError(error)))
                }
            }
        }
        dataTask.resume()
    }
}

