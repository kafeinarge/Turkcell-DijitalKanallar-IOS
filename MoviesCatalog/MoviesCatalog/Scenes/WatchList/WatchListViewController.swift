//
//  WatchListViewController.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import UIKit

public final class WatchListViewController: UIViewController {
    
    internal var viewModel: WatchListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var movies: [MoviePresentation] = []
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadMovies()
    }
}


extension WatchListViewController: WatchListViewModelDelegate {
    public func handleViewModelOutput(_ output: WatchListViewModelOutput) {
        switch output {
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
        case .showMovies(let moviesPresentation):
            DispatchQueue.main.async {
                self.movies = moviesPresentation
                self.tableView.reloadData()
            }
        case .updateTitle(let title):
            DispatchQueue.main.async {
                self.navigationItem.title = title
            }
        case .showError(let error):
            switch error {
            case .networkError(internal: let internalError):
                showAlert(message: internalError.localizedDescription)
            case .serializationError(internal: let internalError):
                print(internalError.localizedDescription)
            }
            
        }
    }
    
}

extension WatchListViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchListTableViewCell", for: indexPath) as! WatchListTableViewCell
        let movie = movies[indexPath.row]
        cell.setCell(movie: movie)
        return cell
    }
}


