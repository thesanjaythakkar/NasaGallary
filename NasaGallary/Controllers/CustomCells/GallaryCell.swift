//
//  GallaryCell.swift
//  NasaGallary
//
//  Created by Sanjay Thakkar on 05/10/22.
//

import UIKit

class GallaryCell: UICollectionViewCell {

    var cornerRadius: CGFloat = 5.0
    @IBOutlet var imgPhoto: UIImageView!
    
        override func awakeFromNib() {
            super.awakeFromNib()
                
            // Apply rounded corners to contentView
            contentView.layer.cornerRadius = cornerRadius
            contentView.layer.masksToBounds = true
            
            // Set masks to bounds to false to avoid the shadow
            // from being clipped to the corner radius
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = false
            
            // Apply a shadow
            layer.shadowRadius = 12.0
            layer.shadowOpacity = 0.60
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 8)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            // Improve scrolling performance with an explicit shadowPath
            layer.shadowPath = UIBezierPath(
                roundedRect: bounds,
                cornerRadius: cornerRadius
            ).cgPath
        }

}
