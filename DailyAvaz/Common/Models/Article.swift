//
//  Article.swift
//  DailyAvaz
//
//  Created by Matej Korman on 03/10/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

struct Article: Codable {
    let id: Int
    let categoryId: Int
    let category: String
    let categoryColor: String
    let url: String
    let uppertitle: String
    let titleRaw: String
    let intro: String
    let shares: Int
    let hasVideo: Bool
    let hasGallery: Bool
    let publishedAt: PublishedAt
    let featuredImage: FeaturedImage
    let featuredImageSource: String?
    let featuredImageCaption: String?
    let author: String
    let autoRelatedArticles: [AutoRelatedArticle]?
    let content: [Content]
}

struct PublishedAt: Codable {
    let date: Date
    let timezoneType: Int
    let timezone: String
}

struct FeaturedImage: Codable {
    let original: String
}

struct AutoRelatedArticle: Codable {
    let id: Int
    let categoryId: Int
    let category: String
    let categoryColor: String
    let titleRaw: String
    let shares: Int
    let hasVideo: Bool
    let hasGallery: Bool
    let publishedAt: PublishedAt
    let featuredImage: FeaturedImage
}

struct Content: Codable {
    let type: String
    let data: String
    let embedSrc: String?
    let gallery: [FeaturedImage]?
    let image: FeaturedImage?
}
