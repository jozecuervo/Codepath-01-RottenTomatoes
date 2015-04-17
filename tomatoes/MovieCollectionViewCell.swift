//
//  MovieCollectionViewCell.swift
//  tomatoes
//
//  Created by Gabe Kangas on 4/17/15.
//  Copyright (c) 2015 Gabe Kangas. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    
    let ratingImage = UIImageView()
    
    override func awakeFromNib() {
        contentView.addSubview(ratingImage)
        ratingImage.image = UIImage(named: "rotten.png")
        ratingImage.backgroundColor = UIColor.clearColor()
        prepareForReuse()
        
    }
    
    override func prepareForReuse() {
        ratingImage.hidden = true
        
        let originalSize = CGSizeMake(self.frame.size.width + 10, self.frame.size.width + 10)
        ratingImage.frame.size = originalSize
        ratingImage.center = contentView.center

    }
    
    func animateRating() {
        ratingImage.hidden = false
        let destinationSize = CGSizeMake(50, 50)
        
        UIView.animateWithDuration(1.5, animations: { () -> Void in
            self.ratingImage.center = self.contentView.center
            self.ratingImage.frame.size = destinationSize
        }) { (completed) -> Void in
            //
        }
        
    }
}
