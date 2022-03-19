//
//  SearchViewController.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import UIKit

public final class SearchViewController: UIViewController {
    
    public var viewModel: SearchViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: Values
    
    private var movies: [MoviePresentation] = []
    private var isSearchBarEmpty: Bool {
        return searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchBar.selectedScopeButtonIndex != -1
        return (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        settings()
        viewModel.load()
    }
    
}

extension SearchViewController: SearchViewModelDelegate {
    public func handleViewModelOutput(_ output: SearchViewModelOutput) {
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
        case .showMovies(let movies):
            DispatchQueue.main.async {
                self.movies.removeAll()
                self.movies = movies
                self.tableView.reloadData()
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
    
    public func navigate(to route: SearchViewModelRoute) {
        switch route {
        case .movieDetail(let movieId):
            let movieDetailViewController = MovieDetailBuilder.make(id: movieId)
            self.navigationController?.show(movieDetailViewController, sender: nil)
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.title
        return cell
    }
}



extension SearchViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let id = movies[indexPath.row].id
        viewModel.selectMovie(at: id)
    }
    
}


extension SearchViewController: UISearchBarDelegate {
    // Search Bar
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 3 {
            viewModel.search(text: searchText)
        } else if searchText.count == 0 {
            DispatchQueue.main.async {
                self.movies.removeAll()
                self.searchBar.resignFirstResponder()
                self.tableView.reloadData()
            }
        }
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.searchBar.resignFirstResponder()
            self.tableView.reloadData()
        }
    }
    
}

extension SearchViewController  {
    func settings() {
        // Large title
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .never
        // SearchBar Definitioan
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.searchBar.placeholder = "Please Enter"
        
        // Status Bar settings
        let statusBarHeight: CGFloat = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let statusbarView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: statusBarHeight))
        statusbarView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.view.addSubview(statusbarView)
        
        setTapRecognizer()
    }
    
    func setTapRecognizer() {
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.keyboardDismiss))
        
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func keyboardDismiss() {
        searchBar.resignFirstResponder()
    }
}



