//
//  Movie.swift
//  tomatoes
//
//  Created by Gabe Kangas on 4/17/15.
//  Copyright (c) 2015 Gabe Kangas. All rights reserved.
//

import UIKit

class Movie {
    
    var displayed = false
    var name :String = ""
    var imageUrl :NSURL!
    var cast :NSArray!
   
    var rating :Int!
    var criticsRating :Int!

    convenience init(dictionary: NSDictionary) {
        self.init()

        name = dictionary.valueForKey("title") as! String
        imageUrl = getImageUrl(dictionary)
        rating = dictionary.valueForKeyPath("ratings.audience_score") as! NSInteger
        criticsRating = dictionary.valueForKeyPath("ratings.critics_score") as! NSInteger
    }
    
    func getImageUrl(dictionary :NSDictionary) -> NSURL! {
        var urlString = dictionary.valueForKeyPath("posters.original") as! String
        var range = urlString.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
        if let range = range {
            urlString = urlString.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
        }
        
        cast = dictionary.objectForKey("abridged_cast") as! NSArray
        
        return NSURL(string:urlString)
    }
}
