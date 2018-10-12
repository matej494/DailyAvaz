//
//  SingleTitlesTableViewCell.swift
//  DailyAvaz
//
//  Created by Matej Korman on 05/10/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit
import SnapKit

class SingleTitlesTableViewCell: UITableViewCell {
    static let identifier = String(describing: SingleTitlesTableViewCell.self)
    
    struct DataModel {
        let upperTitle: String
        let title: String
        let subTitle: String
    }
    
    private let upperTitleLabel = UILabel.autolayoutView()
    private let separatorView = SeparatorView.autolayoutView()
    private let titleLabel = UILabel.autolayoutView()
    private let subTitileLabel = UILabel.autolayoutView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SingleTitlesTableViewCell {
    func updateProperties(dataModel: DataModel) {
        upperTitleLabel.text = dataModel.upperTitle
        titleLabel.text = dataModel.title
        subTitileLabel.text = dataModel.subTitle
    }
}

private extension SingleTitlesTableViewCell {
    func setupViews() {
        selectionStyle = .none
        setupUpperTitleLabel()
        setupSeparatorView()
        setupTitleLabel()
        setupSubTitleLabel()
    }
    
    func setupUpperTitleLabel() {
        upperTitleLabel.font = .custom(type: RobotoSlab.bold, ofSize: 14)
        upperTitleLabel.numberOfLines = 0
        upperTitleLabel.lineBreakMode = .byWordWrapping
        contentView.addSubview(upperTitleLabel)
        upperTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(8)
        }
    }
    
    func setupSeparatorView() {
        contentView.addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(upperTitleLabel.snp.bottom).inset(-8)
        }
    }
    
    func setupTitleLabel() {
        titleLabel.font = .custom(type: RobotoSlab.regular, ofSize: 26)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(separatorView.snp.bottom).inset(-8)
        }
    }
    
    func setupSubTitleLabel() {
        subTitileLabel.font = .custom(type: Roboto.medium, ofSize: 14)
        subTitileLabel.numberOfLines = 0
        subTitileLabel.textColor = UIColor.black.withAlphaComponent(0.6)
        subTitileLabel.lineBreakMode = .byWordWrapping
        contentView.addSubview(subTitileLabel)
        subTitileLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(titleLabel.snp.bottom).inset(-16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
