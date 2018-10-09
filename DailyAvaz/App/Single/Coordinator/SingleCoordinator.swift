//
//  SingleCoordinator.swift
//  DailyAvaz
//
//  Created by Matej Korman on 04/10/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

class SingleCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var presenter: UINavigationController
    
    private var controller: UIViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        controller = UIViewController()
    }
    
    func start() {
        presenter.pushViewController(controller, animated: true)
    }
}
