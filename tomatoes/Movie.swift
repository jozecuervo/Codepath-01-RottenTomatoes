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
    
    convenience init(dictionary: NSDictionary) {
        self.init()

        name = "Test movie name"
    }
    
}
