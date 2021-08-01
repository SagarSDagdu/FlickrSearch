//
//  Constants.swift
//  FlickrSearch
//
//  Created by Sagar Dagdu on 01/08/21.
//

import Foundation

struct AppConstants {
    /// The API key
    static let apiKey = "2932ade8b209152a7cbb49b631c4f9b6"
    static let perPagePhotos = 50
}

struct SearchAPIKeys {
    static let method = "method"
    static let apiKey = "api_key"
    static let format = "format"
    static let safeSearch = "safe_search"
    static let noJsonCallback = "nojsoncallback"
    static let text = "text"
    static let page = "page"
    static let perPage = "per_page"
}

struct SearchAPIValues {
    static let scheme = "https"
    static let host = "api.flickr.com"
    static let path = "/services/rest"
    
    static let method = "flickr.photos.search"
    static let apiKey = AppConstants.apiKey
    static let format = "json"
    static let safeSearch = "1"
    static let noJsonCallback = "1"
}
