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
    var ratingImageFilename :String! {
        didSet {
            ratingImage.image = UIImage(named: ratingImageFilename)
        }
    }
    
    let ratingImage = UIImageView()
    
    override func awakeFromNib() {
        contentView.addSubview(ratingImage)
        ratingImage.backgroundColor = UIColor.clearColor()
        prepareForReuse()
        movieName.center = CGPoint(x: -150, y: movieName.center.y)
    }
    
    override func prepareForReuse() {
        ratingImage.hidden = true
        
        let originalSize = CGSizeMake(self.frame.size.width + 10, self.frame.size.width + 10)
        ratingImage.frame.size = originalSize
        ratingImage.center = movieImageView.center

    }
    
    func animate(delay: Double = 0) {
        ratingImage.alpha = 0.0
        ratingImage.hidden = false
        let destinationSize = CGSizeMake(50, 50)
        UIView.animateWithDuration(0.7, delay: 0.7 + delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.4, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            self.ratingImage.center = CGPointMake(100,100)
            self.ratingImage.frame.size = destinationSize
            self.ratingImage.alpha = 1.0
            self.movieName.frame.origin.x = 5
        }) { (complete) -> Void in
            //
        }
        
    }
    
    func layout() {
        ratingImage.hidden = false
        ratingImage.alpha = 1.0
        let destinationSize = CGSizeMake(50, 50)
        ratingImage.center = CGPointMake(100,100)
        ratingImage.frame.size = destinationSize
    }
}
