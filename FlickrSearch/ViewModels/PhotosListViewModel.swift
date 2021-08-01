//
//  PhotosListViewModel.swift
//  FlickrSearch
//
//  Created by Sagar Dagdu on 01/08/21.
//

import Foundation

final class PhotosListViewModel {
    private var flickrSearchProvider: FlickrProviding
    
    private(set) var photos: [Photo] = []
    private(set) var currentSearchPage = 1
    private(set) var isCurrentlyFetching = false
    private(set) var searchReachedEnd = false
    
    var currentSearchString = ""
    
    init(flickrProvider: FlickrProviding) {
        self.flickrSearchProvider = flickrProvider
    }
    
    func resetSearch() {
        currentSearchPage = 1
        photos = []
        currentSearchString = ""
        searchReachedEnd = false
    }
    
    func fetchNextImages(completion: (() -> Void)? = nil) {
        guard !isCurrentlyFetching else {
            print("Fetch already in progress...")
            completion?()
            return
        }
        
        guard !searchReachedEnd else {
            print("Search reached end for the current search string...")
            completion?()
            return
        }
        
        isCurrentlyFetching = true
        flickrSearchProvider.getFlickrPhotos(for: currentSearchString,
                                             page: currentSearchPage,
                                             perPage: AppConstants.perPagePhotos) { [weak self] result in
            self?.isCurrentlyFetching = false
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    if let photoCollection = response.photos?.photoCollection {
                        // If there are no new photos or we reach the page count, stop
                        if photoCollection.isEmpty || response.photos?.pages == self?.currentSearchPage {
                            self?.searchReachedEnd = true
                        } else {
                            self?.photos.append(contentsOf: photoCollection)
                            self?.currentSearchPage += 1
                        }
                        
                        completion?()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
