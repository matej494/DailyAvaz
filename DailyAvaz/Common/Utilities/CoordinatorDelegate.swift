//
//  CoordinatorDelegate.swift
//  FactoryWeather
//
//  Created by Matej Korman on 21/09/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

protocol CoordinatorDelegate: class {
    func viewControllerHasFinished()
}

protocol ParentCoordinatorDelegate: class {
    func childHasFinished(coordinator: Coordinator)
}
