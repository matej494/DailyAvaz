//
//  SingleViewController.swift
//  DailyAvaz
//
//  Created by Matej Korman on 04/10/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class SingleViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let singleView = SingleView()
    private let viewModel: SingleViewModel
    
    enum DataState {
        case loading
        case ready
    }
    
    init(viewModel: SingleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupBackButton()
        setupTitleView()
        setupView()
        setupSingleView()
        setupObservers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNavigationBar()
        viewModel.initializeData().disposed(by: disposeBag)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            viewModel.singleCoordinatorDelegate?.viewControllerHasFinished()
        }
    }
}

extension SingleViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataModel = viewModel.dataModelForRow(forIndexPath: indexPath)
        switch dataModel {
        case .loading:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LoaderTableViewCell.identifier, for: indexPath) as? LoaderTableViewCell else {
                return UITableViewCell()
            }
            cell.startAnimating()
            return cell
        case .coverImage(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SingleCoverImageTableViewCell.identifier, for: indexPath) as? SingleCoverImageTableViewCell else {
                return UITableViewCell()
            }
            cell.updateProperties(dataModel: data)
            return cell
        case .title(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SingleTitlesTableViewCell.identifier, for: indexPath) as? SingleTitlesTableViewCell else {
                return UITableViewCell()
            }
            cell.updateProperties(dataModel: data)
            return cell
        case .details(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SingleDetailsTableViewCell.identifier, for: indexPath) as? SingleDetailsTableViewCell else {
                return UITableViewCell()
            }
            cell.updateProperties(dataModel: data)
            return cell
        case .text(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SingleTextTableViewCell.identifier, for: indexPath) as? SingleTextTableViewCell else {
                return UITableViewCell()
            }
            cell.updateProperties(dataModel: data)
            return cell
        }
    }
}

private extension SingleViewController {
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

private extension SingleViewController {
    func setupBackButton() {
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "back_button"), style: .plain, target: self, action: #selector(backButtonTapped))
        barButtonItem.tintColor = .white
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    func setupTitleView() {
        let titleView = UIView.autolayoutView()
        let titleLabel = UILabel.autolayoutView()
        let titleImageView = UIImageView.autolayoutView()
        
        titleLabel.text = "Vijesti"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.custom(type: RobotoSlab.bold, ofSize: 17)
        titleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        titleImageView.image = UIImage(named: "logo_small")
        titleView.addSubview(titleImageView)
        titleImageView.snp.makeConstraints {
            $0.trailing.equalTo(titleLabel.snp.leading).inset(-8)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }
        navigationItem.titleView = titleView
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .avazRed
        navigationController?.navigationBar.barStyle = .black
    }
    
    func setupSingleView() {
        singleView.tableView.dataSource = self
        view.addSubview(singleView)
        singleView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func setupView() {
        view.backgroundColor = .white
    }
    
    func setupObservers() {
        viewModel.dataState
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { state in
                self.singleView.tableView.reloadData()
            })
        .disposed(by: disposeBag)
    }
}
