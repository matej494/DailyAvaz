//
//  AppCoordinator.swift
//  FactoryWeather
//
//  Created by Matej Korman on 21/09/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var presenter: UINavigationController
    
    private let window: UIWindow

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

extension AppCoordinator: ParentCoordinatorDelegate {
    func childHasFinished(coordinator: Coordinator) {
        removeChildCoordinator(childCoordinator: coordinator)
    }
}
