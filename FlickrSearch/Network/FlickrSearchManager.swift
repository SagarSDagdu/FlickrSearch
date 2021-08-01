//
//  FlickrSearchManager.swift
//  FlickrSearch
//
//  Created by Sagar Dagdu on 01/08/21.
//

import Foundation

protocol FlickrProviding {
    var network: Networking { get }
    
    func getFlickrPhotos(for searchString: String,
                         page: Int,
                         perPage: Int,
                         completion: @escaping (Result<FlickrApiResponse, Error>) -> Void)
}

final class FlickrSearchManager: FlickrProviding {
    internal var network: Networking
    
    init(withNetwork network: Networking) {
        self.network = network
    }
    
    func getFlickrPhotos(for searchString: String, page: Int, perPage: Int, completion: @escaping (Result<FlickrApiResponse, Error>) -> Void) {
        network.fetch(.flickrSearch(text: searchString, page: page, perPage: perPage), completion: completion)
    }
}


