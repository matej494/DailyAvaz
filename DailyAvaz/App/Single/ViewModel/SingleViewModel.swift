//
//  SingleViewModel.swift
//  DailyAvaz
//
//  Created by Matej Korman on 04/10/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SingleViewModel {
    var singleCoordinatorDelegate: SingleCoordinatorDelegate? { get set }
    var dataState: BehaviorRelay<SingleViewController.DataState> { get }
    
    func initializeData() -> Disposable
    func numberOfSections() -> Int
    func numberOfRows() -> Int
    func dataModelForRow(forIndexPath indexPath: IndexPath) -> SingleViewCellType
}
