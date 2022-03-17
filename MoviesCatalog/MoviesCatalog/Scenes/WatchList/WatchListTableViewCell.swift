//
//  WatchListTableViewCell.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import UIKit

class WatchListTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
}

extension WatchListTableViewCell {
    func setCell(movie: MoviePresentation) {
        lblName.text = movie.title
        movieImageView.setRoundFrame()
        if movie.image != nil {
            movieImageView.loadImage(urlString: movie.image!)
        } else if let imageData = movie.imageData {
            guard let image: UIImage = UIImage(data: imageData) else {return}
            movieImageView.image = image
        }
    }
}
