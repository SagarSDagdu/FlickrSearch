//
//  FlickrApiResponse.swift
//  FlickrSearch
//
//  Created by Sagar Dagdu on 01/08/21.
//

import Foundation

// MARK: - FlickrApiResponse
struct FlickrApiResponse: Codable {
    var photos: Photos?
    var stat: String?
}

// MARK: - Photos
struct Photos: Codable {
    var page: Int?
    var pages: Int?
    var perPage: Int?
    var total: Int?
    var photoCollection: [Photo]?
    
    enum CodingKeys: String, CodingKey {
        case page, pages, total
        case perPage = "perpage"
        case photoCollection = "photo"
    }
}
