//
//  LoginViewController.swift
//  Movies Viper
//
//  Created by Carlos on 23/04/25.
//

import UIKit

class LoginViewController: UIViewController, LoginViewProtocol {
    var presenter: LoginPresenterProtocol!
    

    private let usernameField = UITextField()
    private let passwordField = UITextField()
    private let loginButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.navigationController?.navigationBar.isHidden = true
        self.edgesForExtendedLayout = [.top, .bottom]
        self.extendedLayoutIncludesOpaqueBars = true
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
       
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.overrideUserInterfaceStyle = .dark

        self.navigationController?.setNeedsStatusBarAppearanceUpdate()


    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }


    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        let bottomPadding: CGFloat = 32
        let keyboardHeight = keyboardFrame.height

        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = -keyboardHeight + bottomPadding
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }


    private func setupUI() {
        let topFillView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        topFillView.backgroundColor = .black
        view.insertSubview(topFillView, at: 0)
        // Imagen de fondo
        let posterImageView = UIImageView()
        posterImageView.image = UIImage(named: "alien")
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.frame = UIScreen.main.bounds
        posterImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(posterImageView, at: 0)


        // Degradado oscuro
        let gradientOverlay = UIView()
        gradientOverlay.frame = UIScreen.main.bounds
        gradientOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(gradientOverlay, aboveSubview: posterImageView)

        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.7).cgColor,
            UIColor.black.cgColor
        ]
        gradient.locations = [0.0, 0.6, 1.0]
        gradient.frame = UIScreen.main.bounds
        gradientOverlay.layer.addSublayer(gradient)


        // Título
        let titleLabel = UILabel()
        titleLabel.text = "Sign In"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center

        // Inputs
        usernameField.placeholder = "Username"
        usernameField.borderStyle = .roundedRect
        usernameField.backgroundColor = UIColor(white: 1, alpha: 0.15)
        usernameField.textColor = .white
        usernameField.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [.foregroundColor: UIColor.lightGray]
        )

        passwordField.placeholder = "Password"
        passwordField.borderStyle = .roundedRect
        passwordField.backgroundColor = UIColor(white: 1, alpha: 0.15)
        passwordField.textColor = .white
        passwordField.isSecureTextEntry = true
        passwordField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [.foregroundColor: UIColor.lightGray]
        )

        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .systemPurple
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 8
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [titleLabel, usernameField, passwordField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            // Imagen y degradado hasta los bordes
            posterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: -view.safeAreaInsets.top),
            posterImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            gradientOverlay.topAnchor.constraint(equalTo: view.topAnchor),
            gradientOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradientOverlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientOverlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            // Stack de inputs al fondo
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
        ])
  }
    

    @objc private func loginTapped() {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        presenter.loginTapped(username: username, password: password)
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
