//
//  SingleCoverImageTableViewCell.swift
//  DailyAvaz
//
//  Created by Matej Korman on 04/10/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class SingleCoverImageTableViewCell: UITableViewCell {
    let gradientLayer = CAGradientLayer()

    static let identifier = String(describing: SingleCoverImageTableViewCell.self)
    
    struct DataModel {
        let imageUrl: URL
        let category: String
        let categoryColor: UIColor
        let source: String?
        let caption: String?
    }
    
    private let containerView = UIView.autolayoutView()
    private let coverImageView = UIImageView.autolayoutView()
    private let textBackgrounView = UIView.autolayoutView()
    private let labelsStackView = UIStackView.autolayoutView()
    private let categoryAndBookmarkView = UIView.autolayoutView()
    private let categoryContainerView = UIView.autolayoutView()
    private let categoryLabel = UILabel.autolayoutView()
    private let bookmarkImageView = UIImageView.autolayoutView()
    private let sourceLabel = UILabel.autolayoutView()
    private let messageLabel = UILabel.autolayoutView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.bounds
    }
}

extension SingleCoverImageTableViewCell {
    func updateProperties(dataModel: DataModel) {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.8).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.7)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        textBackgrounView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        textBackgrounView.layer.addSublayer(gradientLayer)
        coverImageView.kf.setImage(with: dataModel.imageUrl)
        labelsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        labelsStackView.addArrangedSubview(categoryAndBookmarkView)
        categoryLabel.text = dataModel.category
        categoryContainerView.backgroundColor = dataModel.categoryColor
        if let source = dataModel.source,
            !source.isEmpty {
            sourceLabel.text = dataModel.source
            labelsStackView.addArrangedSubview(sourceLabel)
        }
        if let caption = dataModel.caption,
            !caption.isEmpty {
            messageLabel.text = dataModel.caption
            labelsStackView.addArrangedSubview(messageLabel)
        }
        
        if let imageSize = coverImageView.image?.size {
            let imageRatio = Float(imageSize.height) / Float(imageSize.width)
            coverImageView.snp.remakeConstraints {
                $0.edges.equalToSuperview()
                $0.height.equalTo(coverImageView.snp.width).multipliedBy(imageRatio).priority(.high)
            }
        }
        layoutIfNeeded()
    }
}

private extension SingleCoverImageTableViewCell {
    func setupViews() {
        selectionStyle = .none
        setupContainerView()
        setupCoverImageView()
        setupTextBackgroundView()
        setupLabelsStackView()
        setupCategoryAndBookmarkView()
        setupCategoryContainerView()
        setupCategoryLabel()
        setupBookmarkImageView()
        setupSourceLabel()
        setupMessageLabel()
    }
    
    func setupContainerView() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func setupCoverImageView() {
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        coverImageView.kf.indicatorType = .activity
        containerView.addSubview(coverImageView)
        coverImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func setupTextBackgroundView() {
        containerView.addSubview(textBackgrounView)
        textBackgrounView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func setupLabelsStackView() {
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 8
        containerView.addSubview(labelsStackView)
        labelsStackView.snp.makeConstraints { $0.leading.trailing.bottom.equalToSuperview().inset(16) }
    }
    
    func setupCategoryAndBookmarkView() {
        labelsStackView.addArrangedSubview(categoryAndBookmarkView)
    }
    
    func setupCategoryContainerView() {
        categoryAndBookmarkView.addSubview(categoryContainerView)
        categoryContainerView.snp.makeConstraints { $0.leading.top.bottom.equalToSuperview() }
    }
    
    func setupCategoryLabel() {
        categoryLabel.textColor = .white
        categoryLabel.font = .custom(type: Roboto.regular, ofSize: 12)
        categoryContainerView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview().inset(3)
        }
    }
    
    func setupBookmarkImageView() {
        bookmarkImageView.image = UIImage(named: "bookmark")
        bookmarkImageView.clipsToBounds = false
        bookmarkImageView.contentMode = .scaleAspectFill
        categoryAndBookmarkView.addSubview(bookmarkImageView)
        bookmarkImageView.snp.makeConstraints {
            $0.leading.equalTo(categoryContainerView.snp.trailing).inset(-16)
            $0.trailing.lessThanOrEqualToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(22)
        }
    }
    
    func setupSourceLabel() {
        sourceLabel.textColor = .white
        sourceLabel.font = .custom(type: Roboto.regular, ofSize: 12)
    }
    
    func setupMessageLabel() {
        messageLabel.textColor = .white
        messageLabel.font = .custom(type: Roboto.regular, ofSize: 12)
    }
}
