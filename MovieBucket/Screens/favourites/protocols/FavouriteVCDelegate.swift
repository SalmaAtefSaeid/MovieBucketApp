//
//  FavouriteVCDelegate.swift
//  MovieBucket
//
//  Created by JETS Mobile Lab-12 on 5/19/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import Foundation
import CoreData

protocol FavouriteVCDelegate {
    func setMovies(movieList: [Movie])
//    func populateMovie(movie: NSManagedObject) -> Movie
}
