//
//  SingleView.swift
//  DailyAvaz
//
//  Created by Matej Korman on 04/10/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit
import SnapKit

class SingleView: UIView {
    let tableView = UITableView.autolayoutView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SingleView {
    func setupViews() {
        //TDOD: Register cells
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(LoaderTableViewCell.self, forCellReuseIdentifier: LoaderTableViewCell.identifier)
        tableView.register(SingleCoverImageTableViewCell.self, forCellReuseIdentifier: SingleCoverImageTableViewCell.identifier)
        tableView.register(SingleTitlesTableViewCell.self, forCellReuseIdentifier: SingleTitlesTableViewCell.identifier)
        tableView.register(SingleDetailsTableViewCell.self, forCellReuseIdentifier: SingleDetailsTableViewCell.identifier)
        tableView.register(SingleTextTableViewCell.self, forCellReuseIdentifier: SingleTextTableViewCell.identifier)
        tableView.register(SingleImageTableViewCell.self, forCellReuseIdentifier: SingleImageTableViewCell.identifier)
        addSubview(tableView)
        tableView.snp.makeConstraints({ $0.edges.equalTo(safeAreaLayoutGuide) })
    }
}
