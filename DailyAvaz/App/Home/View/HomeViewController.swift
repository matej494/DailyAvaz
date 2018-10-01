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
    private var image: UIImage?
    
    enum State {
        case loading
        case dataReady
        case error
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupHomeView()
        setupObservers()
        viewModel.initializeData().disposed(by: disposeBag)
        
        APIManager.getCoverImage(with: "https://avaz.ba/media/2018/09/26/716281/press-sbb-5.jpg", success: { data in
            self.image = UIImage(data: data)
            self.homeView.tableView.reloadData()
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNavigationBar()
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        let dataModel = NewsTableViewCell.DataModel(image: image ?? UIImage(named: "logo_big")!,
                                                    category: "Vijesti",
                                                    categoryBackgroundColor: .avazRed,
                                                    hasGallery: true,
                                                    hasVideo: true,
                                                    title: "Title",
                                                    subtitle: "Subtitle",
                                                    timeSinceRelease: "Prije 5 min",
                                                    shares: 1)
        cell.updateView(dataModel: dataModel)
        return cell
    }
}

private extension HomeViewController {
    func setupView() {
        title = "Vijesti"
        view.backgroundColor = .white
    }
    
    func setupHomeView() {
        homeView.tableView.dataSource = self
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
        viewModel.stateChanged
            .subscribe(onNext: { [unowned self] viewControllerState in
                self.stateChanged(state: viewControllerState)
            })
            .disposed(by: disposeBag)
    }
    
    func stateChanged(state: State) {
        // Reload view
        print(state)
    }
}
