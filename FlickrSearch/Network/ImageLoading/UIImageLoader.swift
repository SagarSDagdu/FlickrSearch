//
//  UIImageLoader.swift
//  FlickrSearch
//
//  Created by Sagar Dagdu on 01/08/21.
//

import UIKit

final class UIImageLoader {

    private let imageFetcher: ImageFetcher
    
    init(imageFetcher: ImageFetcher) {
        self.imageFetcher = imageFetcher
    }
    
    private var uuidMap = [UIImageView: UUID]()
    
    func load(_ url: URL, for imageView: UIImageView) {
        let identifer = imageFetcher.loadImage(url) { result in
            defer {
                self.uuidMap[imageView] = nil
            }

            do {
                let image = try result.get()
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } catch {
                print("Error in UIImageLoader: \(error.localizedDescription)")
            }
        }
        
        if let identifer = identifer {
            uuidMap[imageView] = identifer
        }
    }
    
    
    func cancel(for imageView: UIImageView) {
        if let identifier = uuidMap[imageView] {
            imageFetcher.cancelLoad(identifier)
            uuidMap[imageView] = nil
        }
    }
}
