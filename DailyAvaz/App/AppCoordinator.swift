//
//  AppCoordinator.swift
//  FactoryWeather
//
//  Created by Matej Korman on 21/09/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow
    var childCoordinators = [Coordinator]()
    var presenter: UINavigationController

    init(window: UIWindow) {
        self.window = window
        presenter = UINavigationController()
    }
    
    func start() {
        window.rootViewController = presenter
        window.makeKeyAndVisible()
        let homeCoordinator = HomeCoordinator(presenter: presenter)
        addChildCoordinator(childCoordinator: homeCoordinator)
        homeCoordinator.start()
    }
}
