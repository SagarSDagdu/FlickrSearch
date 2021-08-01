//
//  ImageCache.swift
//  FlickrSearch
//
//  Created by Sagar Dagdu on 01/08/21.
//

import UIKit

/// This class acts an a in-memory cache to store data at a particular URL. We use this for caching images
final class ImageCache  {

    //MARK:- Private properties
    
    private var cache = NSCache<NSURL, UIImage>()
    
    //MARK:- Init
    
    init(maxImageCount: Int = 250) {
        self.cache.countLimit = maxImageCount
    }
    
    //MARK:- Public
    
    func image(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }
    
    func setImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}
