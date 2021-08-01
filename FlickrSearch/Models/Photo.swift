//
//  Photo.swift
//  FlickrSearch
//
//  Created by Sagar Dagdu on 01/08/21.
//

import Foundation

// MARK: - Photo

struct Photo: Codable {
    var id: String?
    var owner: String?
    var secret: String?
    var server: String?
    var farm: Int?
    var title: String?
    var isPublic: Int?
    var isFriend: Int?
    var isFamily: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title
        case isPublic = "ispublic"
        case isFriend = "isfriend"
        case isFamily = "isfamily"
    }
}

//MARK:-  Generating Image URL

extension Photo {
    /*
     Sample URL: http://farm1.static.flickr.com/578/23451156376_8983a8ebc7.jpg
     */

    /// Generates the image URL from Photo model
    var flickrImageUrl: String? {
        get {
            if let farm = self.farm,
               let server = self.server,
               let id = self.id,
               let secret = self.secret {
                let url =  "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
                return url
            }
            return nil
        }
    }
}
