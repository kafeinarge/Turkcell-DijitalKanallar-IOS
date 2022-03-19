//
//  FavoritedRemoveAddService.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import Foundation

public final class FavoritedRemoveAddService: FavoritedRemoveAddServiceProtocol  {
    public weak var delegate: FavoritedRemoveAddServiceDelegate?
    
    public init () {}
    
    public func loadFavoritedRemoveAdd(mediaId: Int, favorite: Bool) {
        let api = API.favoriteAddRemove(mediaId: mediaId, favorite: favorite)
        let stringUrl = api.fullUrl
        
        let urlComp =  api.parameters.getComponents(urlString: stringUrl)
        var request = try! URLRequest(url: urlComp.url.unwrap())
        request.httpMethod = api.method
        request.allHTTPHeaderFields = api.headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { [weak self] (data, httpResponse, error) in
            guard let self = self else {return}
            
            if let error =  error {
                self.delegate?.resultFavoritedRemoveAdd(result: .failure(Error.networkError(error)))
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(DefaultResponse.self, from: data)
                    self.delegate?.resultFavoritedRemoveAdd(result: .success(response))
                } catch {
                    self.delegate?.resultFavoritedRemoveAdd(result: .failure(Error.serializationError(error)))
                }
            }
        }
        dataTask.resume()
    }
}
