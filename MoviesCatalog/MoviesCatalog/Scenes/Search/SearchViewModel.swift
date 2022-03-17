//
//  SearchViewModel.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import Foundation

public final class SearchViewModel: SearchViewModelProtocol {
    public weak var delegate: SearchViewModelDelegate?
    private var service: SearchServiceProtocol!
    private var accountService: AccountDetailServiceProtocol!
    
    private var movies: [Movie] = []
    
    init(service: SearchServiceProtocol, accountService: AccountDetailServiceProtocol) {
        self.service = service
        self.service.delegate = self
        self.accountService = accountService
        self.accountService.delegate = self
    }
    
    public func load() {
        notify(.updateTitle("Search"))
        accountService.loadAccountDetail()
    }
    
    public func search(text: String) {
        notify(.setLoading(true))
        service.loadSearch(query: text)
    }
    
    public func selectMovie(at index: Int) {
        delegate?.navigate(to: .movieDetail(index))
    }
    
}

extension SearchViewModel: SearchServiceDelegate, AccountDetailServiceDelegate {
    public func resultSearch(result: Result<MoviesResponse>) {
        notify(.setLoading(false))
        switch result {
        case .success(let response):
            movies.removeAll()
            movies = response.result
            let presentation = response.result.map{ MoviePresentation.init(movie: $0) }
            notify(.showMovies(presentation))
        case .failure(let error):
            print(error)
        }
    }
    
    public func resultAccountDetail(result: Result<AccountDetailResponse>) {
        notify(.setLoading(false))
        switch result {
        case .success(let response):
            Constants.accountId = response.result.accountId
        case .failure(let error):
            notify(.showError(error))
        }
    }
}

extension SearchViewModel {
    private func notify(_ output: SearchViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
