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
        let loginModule = LoginModuleBuilder.build()
        let navigationController = UINavigationController(rootViewController: loginModule)
        window.rootViewController = navigationController
        self.window = window
        window.backgroundColor = .black
        window.makeKeyAndVisible()
        
    }
}
