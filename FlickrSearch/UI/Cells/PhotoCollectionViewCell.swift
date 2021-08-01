//
//  PhotoCollectionViewCell.swift
//  FlickrSearch
//
//  Created by Sagar Dagdu on 01/08/21.
//

import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var onReuse: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 3.0
        imageView.clipsToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        onReuse?()
    }
}
