//
//  SceneDelegate.swift
//  Movies Viper
//
//  Created by Carlos on 23/04/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)

        if SessionManager.isLoggedIn {
            let moviesVC = MoviesListBuilder.build()
            window.rootViewController = UINavigationController(rootViewController: moviesVC)
        } else {
            let loginVC = LoginModuleBuilder.build()
            window.rootViewController = UINavigationController(rootViewController: loginVC)
        }

        window.makeKeyAndVisible()
        window.overrideUserInterfaceStyle = .dark
        self.window = window
        
    }
}
