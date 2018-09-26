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
    let category_id: Int
    let category: String
    let category_color: String
    let url: String
    let title_raw: String
    let intro: String
    let shares: Int
    let has_video: Bool
    let has_gallery: Bool
    let published_at: PublishedAt
    let featured_image: FeaturedImage
    let author: String
    
    struct PublishedAt: Codable {
        let date: String
        let timezone_type: Int
        let timezone: String
    }
    
    struct FeaturedImage: Codable {
        let original: String
    }
}
