//
//  MovieDetailContracts..swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import Foundation

public protocol MovieDetailViewModelProtocol: AnyObject {
    var delegate: MovieDetailViewModelDelegate? { set get }
    func load(id: Int)
    func addRemove(id: Int, type: ProtocolType, data: Data)
    func isContain(id: Int, type: ProtocolType)
}

public enum MovieDetailViewModelOutput: Equatable {
    case updateTitle(String)
    case setLoading(Bool)
    case showMovieDetail(MovieDetailPresentation)
    case showError(Error)
    case isContain(Bool,Bool)
}

public protocol MovieDetailViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: MovieDetailViewModelOutput)
}


