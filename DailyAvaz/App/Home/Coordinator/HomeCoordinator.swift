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
    weak var parentCoordinatorDelegate: ParentCoordinatorDelegate?
    
    private var controller: HomeViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        let viewModel = HomeViewModelImpl()
        controller = HomeViewController(viewModel: viewModel)
        viewModel.homeCoordinatorDelegate = self
    }
    
    func start() {
        presenter.pushViewController(controller, animated: true)
    }
}

extension HomeCoordinator: HomeCoordinatorDelegate {
    func articleTapped(articleIDs: [Int], tappedArticleIndex: Int) {
        let singleCoordinator = SingleCoordinator(presenter: presenter, articleIDs: articleIDs, selectedArticleIndex: tappedArticleIndex)
        singleCoordinator.parentCoordinatorDelegate = self
        addChildCoordinator(childCoordinator: singleCoordinator)
        singleCoordinator.start()
    }
    
    func viewControllerHasFinished() {
        childCoordinators.removeAll()
        parentCoordinatorDelegate?.childHasFinished(coordinator: self)
    }
}

extension HomeCoordinator: ParentCoordinatorDelegate {
    func childHasFinished(coordinator: Coordinator) {
        removeChildCoordinator(childCoordinator: coordinator)
    }
}
