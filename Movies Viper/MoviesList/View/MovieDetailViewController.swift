//
//  MovieDetailViewController.swift
//  Movies Viper
//
//  Created by Carlos on 24/04/25.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    private let movie: Movie

    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .pageSheet
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.05, alpha: 1)
        setupUI()
    }

    private func setupUI() {
        // Botón de cierre
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("✕", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        closeButton.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)

        // Poster
        let posterImageView = UIImageView()
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 8
        posterImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        if let path = movie.posterPath,
           let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)") {
            posterImageView.kf.setImage(with: url)
        }

        // Labels
        let titleLabel = UILabel()
        titleLabel.text = movie.title
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .white

        let releaseLabel = UILabel()
        releaseLabel.text = "Release: \(movie.releaseDate)"
        releaseLabel.textColor = .lightGray
        releaseLabel.font = .systemFont(ofSize: 14)

        let ratingLabel = UILabel()
        ratingLabel.text = "IMDB: \(movie.voteAverage) ⭐️"
        ratingLabel.textColor = .white
        ratingLabel.font = .systemFont(ofSize: 14)

        let overviewLabel = UILabel()
        overviewLabel.text = movie.overview
        overviewLabel.textColor = .white
        overviewLabel.numberOfLines = 0
        overviewLabel.font = .systemFont(ofSize: 15)

        let infoStack = UIStackView(arrangedSubviews: [titleLabel, releaseLabel, ratingLabel])
        infoStack.axis = .vertical
        infoStack.spacing = 4

        let topRow = UIStackView(arrangedSubviews: [infoStack, posterImageView])
        topRow.axis = .horizontal
        topRow.spacing = 16
        topRow.alignment = .top
        topRow.distribution = .fill

        let mainStack = UIStackView(arrangedSubviews: [topRow, overviewLabel])
        mainStack.axis = .vertical
        mainStack.spacing = 20

        view.addSubview(closeButton)
        view.addSubview(mainStack)

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            mainStack.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 16),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    @objc private func dismissModal() {
        dismiss(animated: true)
    }
}
