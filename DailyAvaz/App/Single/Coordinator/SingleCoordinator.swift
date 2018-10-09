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
    weak var parentCoordinatorDelegate: ParentCoordinatorDelegate?
    
    private var controller: SingleViewController
    
    init(presenter: UINavigationController, articleIDs: [Int], selectedArticleIndex: Int) {
        self.presenter = presenter
        let viewModel = SingleViewModelImpl(articleIDs: articleIDs, selectedArticleIndex: selectedArticleIndex)
        controller = SingleViewController(viewModel: viewModel)
        viewModel.singleCoordinatorDelegate = self
    }
    
    func start() {
        presenter.pushViewController(controller, animated: true)
    }
}

extension SingleCoordinator: SingleCoordinatorDelegate {
    func viewControllerHasFinished() {
        childCoordinators.removeAll()
        parentCoordinatorDelegate?.childHasFinished(coordinator: self)
    }
}
