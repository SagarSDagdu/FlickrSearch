//
//  Endpoint.swift
//  FlickrSearch
//
//  Created by Sagar Dagdu on 01/08/21.
//

import Foundation

protocol RequestProviding {
    var urlRequest: URLRequest { get }
}

enum Endpoint {
    case flickrSearch(text: String, page: Int, perPage: Int)
}

extension Endpoint: RequestProviding {
    var urlRequest: URLRequest {
        switch self {
        case .flickrSearch(let text, let page, let perPage):
            let url =  FlickrSearchURLBuilder.buildSearchURL(from: text, page: page, perPage: perPage)
            return URLRequest(url: url)
        }
    }
}
