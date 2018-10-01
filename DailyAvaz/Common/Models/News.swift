//
//  News.swift
//  DailyAvaz
//
//  Created by Matej Korman on 25/09/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

struct APINews: Codable {
    let articles: [News]
}

struct News: Codable {
    let id: Int
    let categoryId: Int
    let category: String
    let categoryColor: String
    let url: String
    let titleRaw: String
    let intro: String
    let shares: Int
    let hasVideo: Bool
    let hasGallery: Bool
    let publishedAt: PublishedAt
    let featuredImage: FeaturedImage
    let author: String
    
    struct PublishedAt: Codable {
        let date: String
        let timezoneType: Int
        let timezone: String
    }
    
    struct FeaturedImage: Codable {
        let original: String
    }
}
