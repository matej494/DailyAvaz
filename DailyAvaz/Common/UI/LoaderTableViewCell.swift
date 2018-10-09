//
//  LoaderTableViewCell.swift
//  DailyAvaz
//
//  Created by Matej Korman on 02/10/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

class LoaderTableViewCell: UITableViewCell {
    static let identifier = "LoaderTableViewCell"
    
    private let activityIndicatorView = UIActivityIndicatorView.autolayoutView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimating() {
        activityIndicatorView.startAnimating()
    }
}

private extension LoaderTableViewCell {
    func setupViews() {
        activityIndicatorView.style = .gray
        contentView.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
}
