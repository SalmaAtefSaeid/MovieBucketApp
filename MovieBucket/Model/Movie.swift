//
//  Movie.swift
//  MovieBucket
//
//  Created by Esraa Hassan on 5/12/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import Foundation

class Movie{
    
    var title : String
    var myImage : Data
    var description :String
    var releaseDate : String
    
    init(title : String, myImage : Data, description :String, releaseDate : String) {
        self.title = title
        self.myImage = myImage
        self.description = description
        self.releaseDate = releaseDate
    }
    
}
