//
//  MovieDetailsPresenter.swift
//  MovieBucket
//
//  Created by JETS Mobile Lab-12 on 5/16/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import Foundation
class MovieDetailsPresenter: MovieDetailsDelegate {

    
    var homeDelegate : HomeDelegate?
    var movieDetailsVCDelegate: MovieDetailsViewControllerDelegate = MovieDetailsViewController()
    
    init() {
        movieDetailsVCDelegate.setDelegate(delegete: self)
    }
    
    func setDelegete(delegete: HomeDelegate) {
        homeDelegate = delegete
    }
    func passMovieDetails(movie: Movie) {
        movieDetailsVCDelegate.setMovieDetails(movie: movie)
    }
    func getFavouriteMovie(movie : Movie) -> (Movie) {
        return movie
    }
    
}
