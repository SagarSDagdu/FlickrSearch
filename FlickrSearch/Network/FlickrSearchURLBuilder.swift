//
//  FlickrSearchURLBuilder.swift
//  FlickrSearch
//
//  Created by Sagar Dagdu on 01/08/21.
//

import Foundation

/// Create a URL from given parameters
final class FlickrSearchURLBuilder {
    static func buildSearchURL(from searchString: String,
                               page: Int,
                               perPage: Int = AppConstants.perPagePhotos) -> URL {
        var components = URLComponents()
                
        components.scheme = SearchAPIValues.scheme
        components.host = SearchAPIValues.host
        components.path = SearchAPIValues.path

        components.queryItems = [URLQueryItem]()
        
        var queryItems: [URLQueryItem] = []

        queryItems.append(URLQueryItem(name: SearchAPIKeys.apiKey, value: AppConstants.apiKey))
        queryItems.append(URLQueryItem(name: SearchAPIKeys.method, value: SearchAPIValues.method))
        queryItems.append(URLQueryItem(name: SearchAPIKeys.format, value: SearchAPIValues.format))
        queryItems.append(URLQueryItem(name: SearchAPIKeys.safeSearch, value: SearchAPIValues.safeSearch))
        queryItems.append(URLQueryItem(name: SearchAPIKeys.noJsonCallback, value: SearchAPIValues.noJsonCallback))
        queryItems.append(URLQueryItem(name: SearchAPIKeys.page, value: "\(page)"))
        queryItems.append(URLQueryItem(name: SearchAPIKeys.perPage, value: "\(perPage)"))
        
        // Append the search string
        queryItems.append(URLQueryItem(name: SearchAPIKeys.text, value: searchString))

        components.queryItems = queryItems
        return components.url!
    }
}
