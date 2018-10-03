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
        setupTableView()
    }
    
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TabBarTableViewCell.self, forCellReuseIdentifier: TabBarTableViewCell.identifier)
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        tableView.register(LoaderTableViewCell.self, forCellReuseIdentifier: LoaderTableViewCell.identifier)
        addSubview(tableView)
        tableView.snp.makeConstraints { $0.leading.top.trailing.bottom.equalTo(safeAreaLayoutGuide) }
    }
}
