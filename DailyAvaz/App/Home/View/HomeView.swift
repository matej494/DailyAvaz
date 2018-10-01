//
//  HomeView.swift
//  DailyAvaz
//
//  Created by Matej Korman on 26/09/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit
import SnapKit

class HomeView: UIView {
    let tableView = UITableView.autolayoutView()
    private let tabBar = TabBarView.autolayoutView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HomeView {
    func setupViews() {
        setupTabBar()
        setupTableView()
    }
    
    func setupTabBar() {
        addSubview(tabBar)
        tabBar.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(24)
            $0.top.equalTo(safeAreaLayoutGuide).inset(15)
            $0.height.equalTo(37)
        }
    }
    
    func setupTableView() {
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(tabBar.snp.bottom).inset(-16)
        }
    }
}
