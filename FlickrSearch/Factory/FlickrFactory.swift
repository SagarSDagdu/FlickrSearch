//
//  FlickrFactory.swift
//  FlickrSearch
//
//  Created by Sagar Dagdu on 01/08/21.
//

import Foundation

protocol FlickrFactoryProviding {
    var networkProvider: Networking { get }
    var flickrSearchProvider: FlickrProviding { get }
    var imageFetcher: ImageFetcher { get }
    var uiImageLoader: UIImageLoader { get }
    var photoListViewModel: PhotosListViewModel { get }
}

class FlickrFactory: FlickrFactoryProviding {
    
    lazy var photoListViewModel: PhotosListViewModel = {
        PhotosListViewModel(flickrProvider: flickrSearchProvider)
    }()
    
    lazy var uiImageLoader: UIImageLoader = {
        UIImageLoader(imageFetcher: imageFetcher)
    }()
    
    lazy var imageFetcher: ImageFetcher = {
       ImageFetcher()
    }()
    
    lazy var networkProvider: Networking = {
        HttpNetwork()
    }()
    
    lazy var flickrSearchProvider: FlickrProviding = {
        FlickrSearchManager(withNetwork: networkProvider)
    }()
    
    static let shared = FlickrFactory()
}

