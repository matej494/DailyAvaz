//
//  NewsTableViewCell.swift
//  DailyAvaz
//
//  Created by Matej Korman on 27/09/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit
import SnapKit

class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"
    
    struct DataModel {
        let image: UIImage
        let category: String
        let categoryBackgroundColor: UIColor
        let hasGallery: Bool
        let hasVideo: Bool
        let title: String
        let subtitle: String
        let timeSinceRelease: String
        let shares: Int
    }
    
    private let coverImageView = UIImageView.autolayoutView()
    private let categoryDetailsStackView = UIStackView.autolayoutView()
    private let categoryDetailsStackBackgroundView = UIView.autolayoutView()
    private let categoryLabel = UILabel.autolayoutView()
    private let galleryImageView = UIImageView.autolayoutView()
    private let videosImageView = UIImageView.autolayoutView()
    private let titleTextView = UILabel.autolayoutView()
    private let subtitleTextView = UILabel.autolayoutView()
    private let detailsView = UIView.autolayoutView()
    private let timeImageView = UIImageView.autolayoutView()
    private let timeLabel = UILabel.autolayoutView()
    private let sharesLabel = UILabel.autolayoutView()
    private let sharesImageView = UIImageView.autolayoutView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewsTableViewCell {
    func updateView(dataModel: NewsTableViewCell.DataModel) {
        coverImageView.image = dataModel.image
        categoryLabel.text = dataModel.category
        categoryDetailsStackView.subviews.forEach { $0.removeFromSuperview() }
        categoryDetailsStackView.addArrangedSubview(categoryLabel)
        if dataModel.hasGallery { categoryDetailsStackView.addArrangedSubview(galleryImageView) }
        if dataModel.hasVideo { categoryDetailsStackView.addArrangedSubview(videosImageView) }
        categoryDetailsStackBackgroundView.backgroundColor = dataModel.categoryBackgroundColor
        titleTextView.text = dataModel.title
        titleTextView.sizeToFit()
        subtitleTextView.text = dataModel.subtitle
        timeLabel.text = dataModel.timeSinceRelease
        sharesLabel.text = "\(dataModel.shares)"
    }
}

private extension NewsTableViewCell {
    func setupViews() {
        setupCoverImageView()
        setupCategoryDetailsStackBackgroundView()
        setupCategoryDetailsStackView()
        setupCategoryLabel()
        setupGalleryImageView()
        setupVideosImageView()
        setupTitleTextView()
        setpSubtitleTextView()
        setupDetailsView()
        setupTimeImageView()
        setupTimeLabel()
        setupSharesLabel()
        setupSharesImageView()
    }
    
    func setupCoverImageView() {
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        contentView.addSubview(coverImageView)
        coverImageView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(217)
        }
    }
    
    func setupCategoryDetailsStackBackgroundView() {
        coverImageView.addSubview(categoryDetailsStackBackgroundView)
        categoryDetailsStackBackgroundView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(178)
        }
    }
    
    func setupCategoryDetailsStackView() {
        categoryDetailsStackView.axis = .horizontal
        categoryDetailsStackView.spacing = 10
        categoryDetailsStackBackgroundView.addSubview(categoryDetailsStackView)
        categoryDetailsStackView.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(6)
            $0.top.bottom.equalToSuperview().inset(3)
        })
    }
    
    func setupCategoryLabel() {
        categoryLabel.textColor = .white
        categoryLabel.font = UIFont.custom(type: Roboto.regular, ofSize: 12)
        categoryDetailsStackView.addArrangedSubview(categoryLabel)
    }
    
    func setupGalleryImageView() {
        galleryImageView.contentMode = .scaleAspectFit
        galleryImageView.clipsToBounds = true
        galleryImageView.image = UIImage(named: "camera_icon")
    }
    
    func setupVideosImageView() {
        videosImageView.contentMode = .scaleAspectFit
        videosImageView.clipsToBounds = true
        videosImageView.image = UIImage(named: "play_icon")
    }
    
    func setupTitleTextView() {
        titleTextView.font = UIFont.custom(type: RobotoSlab.bold, ofSize: 14)
        titleTextView.lineBreakMode = .byTruncatingTail
        titleTextView.numberOfLines = 2
        contentView.addSubview(titleTextView)
        titleTextView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(17)
            $0.top.equalTo(coverImageView.snp.bottom).inset(-8)
        }
    }
    
    func setpSubtitleTextView() {
        subtitleTextView.font = UIFont.custom(type: Lato.regular, ofSize: 13)
        subtitleTextView.lineBreakMode = .byTruncatingTail
        subtitleTextView.numberOfLines = 2
        contentView.addSubview(subtitleTextView)
        subtitleTextView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(17)
            $0.top.equalTo(titleTextView.snp.bottom).inset(-5)
        }
    }
    
    func setupDetailsView() {
        contentView.addSubview(detailsView)
        detailsView.snp.makeConstraints { 
            $0.leading.trailing.equalToSuperview().inset(17)
            $0.top.equalTo(subtitleTextView.snp.bottom).inset(-8)
            $0.bottom.equalToSuperview().inset(9)
        }
    }
    
    func setupTimeImageView() {
        timeImageView.image = UIImage(named: "clock")
        timeImageView.contentMode = .scaleAspectFit
        timeImageView.clipsToBounds = true
        detailsView.addSubview(timeImageView)
        timeImageView.snp.makeConstraints { $0.leading.top.bottom.equalToSuperview() }
    }
    
    func setupTimeLabel() {
        timeLabel.font = UIFont.custom(type: Roboto.regular, ofSize: 12)
        detailsView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(timeImageView.snp.trailing).inset(-5)
            $0.top.bottom.equalToSuperview()
        }
    }
    
    func setupSharesLabel() {
        sharesLabel.font = UIFont.custom(type: Roboto.regular, ofSize: 12)
        sharesLabel.textAlignment = .right
        detailsView.addSubview(sharesLabel)
        sharesLabel.snp.makeConstraints { $0.top.bottom.equalToSuperview() }
    }
    
    func setupSharesImageView() {
        sharesImageView.image = UIImage(named: "share")?.withRenderingMode(.alwaysTemplate)
        sharesImageView.tintColor = .gray
        sharesImageView.contentMode = .scaleAspectFit
        sharesImageView.clipsToBounds = true
        detailsView.addSubview(sharesImageView)
        sharesImageView.snp.makeConstraints {
            $0.leading.equalTo(sharesLabel.snp.trailing).inset(-5)
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
}
