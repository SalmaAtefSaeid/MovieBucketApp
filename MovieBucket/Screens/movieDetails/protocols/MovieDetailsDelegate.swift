//
//  MovieDetailsDelegate.swift
//  MovieBucket
//
//  Created by JETS Mobile Lab-12 on 5/16/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import Foundation
protocol MovieDetailsDelegate {
    
    func passMovieDetails(movie : Movie)
    func setDelegete(delegete: MovieDetailsViewControllerDelegate)
    func setFavouriteMovie(degelate: AppDelegate, movie : Movie)
    func deleteFavouriteMovie(degelate: AppDelegate, movie : Movie)
    func setTrailer(movie: Movie)
    func setReview(movie: Movie)
    func getYoutubeJson (youtubeArrayID : [Video])
    func getReviewJson (reviewArray : [Review])
    
}
