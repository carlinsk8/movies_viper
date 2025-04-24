//
//  MoviesListView.swift
//  Movies Viper
//
//  Created by Carlos on 23/04/25.
//

import UIKit
import Kingfisher

class MoviesListViewController: UIViewController, MoviesListViewProtocol {
    private class MovieCell: UITableViewCell {
        let posterImageView = UIImageView()
        let overlayView = UIView()
        let titleLabel = UILabel()

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            backgroundColor = .clear
            contentView.backgroundColor = .clear

            posterImageView.contentMode = .scaleAspectFill
            posterImageView.clipsToBounds = true
            posterImageView.layer.cornerRadius = 12
            posterImageView.translatesAutoresizingMaskIntoConstraints = false

            overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            overlayView.translatesAutoresizingMaskIntoConstraints = false
            overlayView.layer.cornerRadius = 12
            overlayView.clipsToBounds = true

            titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
            titleLabel.textColor = .white
            titleLabel.numberOfLines = 2
            titleLabel.translatesAutoresizingMaskIntoConstraints = false

            contentView.addSubview(posterImageView)
            contentView.addSubview(overlayView)
            overlayView.addSubview(titleLabel)

            NSLayoutConstraint.activate([
                posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

                overlayView.topAnchor.constraint(equalTo: posterImageView.topAnchor),
                overlayView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor),
                overlayView.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
                overlayView.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor),

                titleLabel.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 12),
                titleLabel.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -12),
                titleLabel.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor, constant: -12)
            ])
            

        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func configure(with movie: Movie) {
            titleLabel.text = movie.title
            if let path = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)") {
               // let processor = DownsamplingImageProcessor(size: CGSize(width: 300, height: 450))
                posterImageView.kf.indicatorType = .activity
                posterImageView.kf.setImage(
                    with: url,
                    placeholder: nil,
                    options: [
                        //.processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(0.3)),
                        .cacheOriginalImage
                    ]
                )
            } else {
                posterImageView.image = nil
            }
        }

        private func loadImage(from url: URL) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.posterImageView.image = image
                }
            }.resume()
        }
    }

    var presenter: MoviesListPresenterProtocol!
    private let tableView = UITableView()
    private var movies: [Movie] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidLoad() {
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(white: 0.05, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        title = "Upcoming Movies"
        view.backgroundColor = UIColor(white: 0.05, alpha: 1)
        
        setupTableView()
        presenter.viewDidLoad()
        
        let logoutIcon = UIImage(named: "logout")?.withRenderingMode(.alwaysTemplate)

        let logoutButton = UIButton(type: .system)
        logoutButton.setImage(logoutIcon, for: .normal)
        logoutButton.tintColor = .white
        logoutButton.imageView?.contentMode = .scaleAspectFit
        logoutButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)

        let container = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        container.addSubview(logoutButton)

        logoutButton.center = CGPoint(x: container.bounds.midX, y: container.bounds.midY)

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: container)


        
    }
    
    @objc private func logoutTapped() {
        SessionManager.logout()

        let loginVC = LoginModuleBuilder.build()
        let nav = UINavigationController(rootViewController: loginVC)
        nav.modalPresentationStyle = .fullScreen

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = nav
            window.makeKeyAndVisible()
        }
    }



    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // tiny scroll to trigger cell refresh
        let offset = tableView.contentOffset
        tableView.setContentOffset(CGPoint(x: offset.x, y: offset.y + 0.5), animated: false)
        tableView.setContentOffset(offset, animated: false)
    }


    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func showMovies(_ movies: [Movie]) {
        self.movies = movies
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.layoutIfNeeded()
        }
    }

    func showError(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
}

extension MoviesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectMovie(movies[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        return screenWidth * (16.0 / 9.0) // relación 9:16
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height * 1.5 {
            presenter.loadMoreMovies()
        }
    }
    
}
