//
//  MovieDetailViewController.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import UIKit

public final class MovieDetailViewController: UIViewController {
    
    public var viewModel: MovieDetailViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var txtViewMovieDescription: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var btnWatchList: UIButton!
    
    private var movieDetailPresentation: MovieDetailPresentation!
    internal var movieId: Int!
    
    private var isFavorited: Bool!
    private var isWatchList: Bool!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.load(id: movieId)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func touchAddRemove(_ sender: UIButton) {
        guard let imageData = movieImageView.image?.jpegData(compressionQuality: 1.0) else {
            return
        }
        
        switch sender.tag {
        case 1:
            viewModel.addRemove(id: movieId, type: .watchList, data: imageData)
        case 2:
            viewModel.addRemove(id: movieId, type: .favoriteList, data: imageData)
        default: break
        }
    }
}

extension MovieDetailViewController: MovieDetailViewModelDelegate {
    public func handleViewModelOutput(_ output: MovieDetailViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            DispatchQueue.main.async {
                self.navigationItem.title = title
            }
        case .setLoading(let isLoading):
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndicator.isHidden = !isLoading
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.isHidden = !isLoading
                    self.activityIndicator.stopAnimating()
                }
            }
        case .showMovieDetail(let movieDetailPresentation):
            self.movieDetailPresentation = movieDetailPresentation
            DispatchQueue.main.async {
                self.movieDetailPresentation = movieDetailPresentation
                self.movieImageView.loadImage(urlString: movieDetailPresentation.image)
                self.lblMovieName.text = movieDetailPresentation.title
                self.lblRating.text = movieDetailPresentation.voteAverage
                self.lblReleaseDate.text = movieDetailPresentation.releaseDate
                self.txtViewMovieDescription.text = movieDetailPresentation.overview
            }
        case .showError(let error):
            switch error {
            case .networkError(internal: let internalError):
                showAlert(message: internalError.localizedDescription)
            case .serializationError(internal: let internalError):
                print(internalError.localizedDescription)
            }
        case .isContain(let isWatchList, let isFavorited):
            self.isFavorited = isFavorited
            self.isWatchList = isWatchList
        }
    }
}

extension MovieDetailViewController {
    func setupUI() {
        self.tabBarController?.tabBar.isHidden = true
        btnFavorite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        btnWatchList.setImage(UIImage(systemName: "list.bullet"), for: .normal)
    }
}
