//
//  ImageFetcher.swift
//  FlickrSearch
//
//  Created by Sagar Dagdu on 01/08/21.
//

import Foundation
import UIKit

final class ImageFetcher {
    lazy private var runningRequests = [UUID : URLSessionDataTask]()
    
    private var session: URLSession
    private var imageCache: ImageCache
    
    init(session: URLSession = URLSession.shared,
         imageCache: ImageCache = .init(maxImageCount: 250)) {
        self.session = session
        self.imageCache = imageCache
    }
    
    func loadImage(_ url: URL,
                   _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        
        if let image = imageCache.image(for: url) {
            completion(.success(image))
            return nil
        }
        
        let uuid = UUID()
        
        let task = session.dataTask(with: url) { data, response, error in
            defer {
                self.runningRequests[uuid] = nil
            }
            
            if let data = data, let image = UIImage(data: data) {
                self.imageCache.setImage(image, for: url)
                completion(.success(image))
                return
            }
            
            guard let error = error else {
                return
            }
            
            guard (error as NSError).code == NSURLErrorCancelled else {
                completion(.failure(error))
                return
            }
        }
        
        task.resume()
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests[uuid] = nil
    }
}
