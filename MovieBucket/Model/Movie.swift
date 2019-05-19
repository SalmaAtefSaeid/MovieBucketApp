//
//  Movie.swift
//  MovieBucket
//
//  Created by Esraa Hassan on 5/12/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import Foundation

class Movie{
    
    var movieId : Int32
    var title : String
    var myImage : String
    var description :String
    var releaseDate : String
    var userRating : Int32
    
    init(movieId : Int32, title : String, myImage : String, description :String, releaseDate : String, userRating : Int32) {
        self.movieId = movieId
        self.title = title
        self.myImage = myImage
        self.description = description
        self.releaseDate = releaseDate
        self.userRating = userRating
    }
    
}
