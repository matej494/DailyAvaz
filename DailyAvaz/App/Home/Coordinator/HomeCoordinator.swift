//
//  HomeCoordinator.swift
//  DailyAvaz
//
//  Created by Matej Korman on 26/09/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var presenter: UINavigationController
    var controller: HomeViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        controller = HomeViewController(viewModel: HomeViewModelImpl())
    }
    
    func start() {
        presenter.pushViewController(controller, animated: true)
    }
}
