//
//  Coordinator.swift
//  FactoryWeather
//
//  Created by Matej Korman on 21/09/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    var presenter: UINavigationController { get }
    func start()
}

extension Coordinator {
    func addChildCoordinator(childCoordinator: Coordinator) {
        self.childCoordinators.append(childCoordinator)
    }
    
    func removeChildCoordinator(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
}
