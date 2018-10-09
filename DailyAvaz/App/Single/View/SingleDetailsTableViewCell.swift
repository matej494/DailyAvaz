//
//  SingleDetailsTableViewCell.swift
//  DailyAvaz
//
//  Created by Matej Korman on 05/10/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

class SingleDetailsTableViewCell: UITableViewCell {
    static let identifier = "SingleDetailsTableViewCell"
    
    struct DataModel {
        let releaseDate: String
        let releasedBefore: String
        let author: String
        let shares: String
    }
    
    private let upperSeparatorView = SeparatorView.autolayoutView()
    private let timeContainerView = UIView.autolayoutView()
    private let timeIconImageView = UIImageView.autolayoutView()
    private let releasedPlaceholderLabel = UILabel.autolayoutView()
    private let releasedDateLabel = UILabel.autolayoutView()
    private let dotView = UIView.autolayoutView()
    private let releasedBeforeLabel = UILabel.autolayoutView()
    private let authorAndSharesView = UIView.autolayoutView()
    private let authorIconImageView = UIImageView.autolayoutView()
    private let authorLabel = UILabel.autolayoutView()
    private let sharesLabel = UILabel.autolayoutView()
    private let sharesIconImageView = UIImageView.autolayoutView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SingleDetailsTableViewCell {
    func updateProperties(dataModel: DataModel) {
        releasedDateLabel.text = dataModel.releaseDate
        releasedBeforeLabel.text = dataModel.releasedBefore
        authorLabel.text = dataModel.author
        sharesLabel.text = dataModel.shares
    }
}

private extension SingleDetailsTableViewCell {
    func setupViews() {
        selectionStyle = .none
        setupUpperSeparatorView()
        setupTimeContainerView()
        setupTimeIconImageView()
        setupReleasedPlaceholderLabel()
        setupReleasedDateLabel()
        setupDotView()
        setupReleasedBeforeLabel()
        setupAuthorAndSharesView()
        setupAuthorIconImageView()
        setupAuthorLabel()
        setupSharesLabel()
        setupSharesIconImageView()
    }
    
    func setupUpperSeparatorView() {
        contentView.addSubview(upperSeparatorView)
        upperSeparatorView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview()
        }
    }
    
    func setupTimeContainerView() {
        contentView.addSubview(timeContainerView)
        timeContainerView.snp.makeConstraints { $0.leading.top.trailing.equalToSuperview().inset(16) }
    }
    
    func setupTimeIconImageView() {
        timeIconImageView.image = UIImage(named: "clock")
        timeIconImageView.contentMode = .scaleAspectFill
        timeContainerView.addSubview(timeIconImageView)
        timeIconImageView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.height.equalTo(16)
        }
    }
    
    func setupReleasedPlaceholderLabel() {
        releasedPlaceholderLabel.font = UIFont.custom(type: Roboto.regular, ofSize: 12)
        releasedPlaceholderLabel.textColor = UIColor.black.withAlphaComponent(0.6)
        releasedPlaceholderLabel.text = "Objavljeno: "
        timeContainerView.addSubview(releasedPlaceholderLabel)
        releasedPlaceholderLabel.snp.makeConstraints {
            $0.leading.equalTo(timeIconImageView.snp.trailing).inset(-8)
            $0.top.bottom.equalToSuperview()
        }
    }
    
    func setupReleasedDateLabel() {
        releasedDateLabel.font = UIFont.custom(type: Roboto.regular, ofSize: 12)
        releasedDateLabel.textColor = UIColor.black.withAlphaComponent(0.6)
        timeContainerView.addSubview(releasedDateLabel)
        releasedDateLabel.snp.makeConstraints {
            $0.leading.equalTo(releasedPlaceholderLabel.snp.trailing).inset(-8)
            $0.top.bottom.equalToSuperview()
        }
    }
    
    func setupDotView() {
        dotView.layer.cornerRadius = 2
        dotView.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        timeContainerView.addSubview(dotView)
        dotView.snp.makeConstraints {
            $0.leading.equalTo(releasedDateLabel.snp.trailing).inset(-8)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(4)
        }
    }
    
    func setupReleasedBeforeLabel() {
        releasedBeforeLabel.font = UIFont.custom(type: Roboto.regular, ofSize: 12)
        releasedBeforeLabel.textColor = UIColor.black.withAlphaComponent(0.6)
        timeContainerView.addSubview(releasedBeforeLabel)
        releasedBeforeLabel.snp.makeConstraints {
            $0.leading.equalTo(dotView.snp.trailing).inset(-8)
            $0.top.bottom.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
    }
    
    func setupAuthorAndSharesView() {
        contentView.addSubview(authorAndSharesView)
        authorAndSharesView.snp.makeConstraints {
            $0.leading.trailing.bottom  .equalToSuperview().inset(16)
            $0.top.equalTo(timeContainerView.snp.bottom).inset(-8)
        }
    }
    
    func setupAuthorIconImageView() {
        authorIconImageView.image = UIImage(named: "author")
        authorIconImageView.contentMode = .scaleAspectFill
        authorAndSharesView.addSubview(authorIconImageView)
        authorIconImageView.snp.makeConstraints { $0.leading.top.bottom.equalToSuperview() }
    }
    
    func setupAuthorLabel() {
        authorLabel.font = UIFont.custom(type: Roboto.regular, ofSize: 12)
        authorLabel.textColor = UIColor.black.withAlphaComponent(0.6)
        authorAndSharesView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints {
            $0.leading.equalTo(authorIconImageView.snp.trailing).inset(-8)
            $0.top.bottom.equalToSuperview()
        }
    }
    
    func setupSharesLabel() {
        sharesLabel.font = UIFont.custom(type: Roboto.regular, ofSize: 12)
        sharesLabel.textColor = UIColor.black.withAlphaComponent(0.6)
        authorAndSharesView.addSubview(sharesLabel)
        sharesLabel.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(authorLabel.snp.trailing).inset(-8)
            $0.top.bottom.equalToSuperview()
        }
    }
    
    func setupSharesIconImageView() {
        sharesIconImageView.image = UIImage(named: "share_filled")
        authorAndSharesView.addSubview(sharesIconImageView)
        sharesIconImageView.snp.makeConstraints {
            $0.leading.equalTo(sharesLabel.snp.trailing).inset(-8)
            $0.top.trailing.bottom.equalToSuperview()
        }
    }
}
