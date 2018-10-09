//
//  HomeViewController.swift
//  DailyAvaz
//
//  Created by Matej Korman on 26/09/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

class HomeViewController: UIViewController {    
    private let disposeBag = DisposeBag()
    private let viewModel: HomeViewModel
    private let homeView = HomeView.autolayoutView()
    private var refreshControll = UIRefreshControl()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupHomeView()
        setupObservers()
        viewModel.initializeData().disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            viewModel.homeCoordinatorDelegate?.viewControllerHasFinished()
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataModel = viewModel.dataModelForRow(forIndexPath: indexPath)
        switch dataModel {
        case .news(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell,
                let dataModel = data else {
                    return UITableViewCell()
            }
            cell.updateView(dataModel: dataModel)
            return cell
        case .loader:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LoaderTableViewCell.identifier, for: indexPath) as? LoaderTableViewCell else {
                return UITableViewCell()
            }
            cell.startAnimating()
            return cell
        case .tabBar:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TabBarTableViewCell.identifier, for: indexPath) as? TabBarTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let indexPath = IndexPath(row: viewModel.numberOfRows() - 3, section: 0)
        guard let newVisableCell = homeView.tableView.visibleCells.last,
            let cell = homeView.tableView.cellForRow(at: indexPath) else {
            return
        }
        if newVisableCell.contains(cell) {
            viewModel.nextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(atIndexPath: indexPath)
    }
}

extension HomeViewController: TabBarDelegate {
    func buttonTapped(atPosition position: Int) {
        if position == 0 {
            viewModel.changeAPICategory(.najnovije)
        } else {
            viewModel.changeAPICategory(.najcitanije)
        }
    }
}

private extension HomeViewController {
    func setupView() {
        title = "Vijesti"
        view.backgroundColor = .white
    }
    
    func setupHomeView() {
        homeView.tableView.dataSource = self
        homeView.tableView.delegate = self
        homeView.tableView.addSubview(refreshControll)
        homeView.tableView.scrollsToTop = true
        view.addSubview(homeView)
        homeView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .avazRed
        navigationController?.navigationBar.barStyle = .black
        if let font = UIFont.custom(type: RobotoSlab.bold, ofSize: 17) {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
        }
    }
    
    func setupObservers() {
        viewModel.dataState
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] viewControllerState in
                self.stateChanged(state: viewControllerState)
            })
            .disposed(by: disposeBag)
        refreshControll.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    func stateChanged(state: HomeViewDataState) {
        switch state {
        case .initialized:
            homeView.tableView.reloadData()
        case .readyPaged(let indexPathsToRemove, let indexPathsToInsert):
            homeView.tableView.performBatchUpdates({
                homeView.tableView.deleteRows(at: indexPathsToRemove, with: .none)
                homeView.tableView.insertRows(at: indexPathsToInsert, with: .none)
            }, completion: nil)
        case .readyRefreshed:
            homeView.tableView.reloadData()
            refreshControll.endRefreshing()
            homeView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        case .loading:
            homeView.tableView.reloadData()
        case .error:
            break
        }
    }
    
    @objc func refreshData() {
        viewModel.refreshData()
    }
}
