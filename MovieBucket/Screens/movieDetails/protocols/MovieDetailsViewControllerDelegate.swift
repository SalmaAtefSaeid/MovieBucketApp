//
//  MovieDetailsViewControllerDelegate.swift
//  MovieBucket
//
//  Created by JETS Mobile Lab-12 on 5/16/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import Foundation
protocol MovieDetailsViewControllerDelegate {
    
    func setMovieDetails(movie : Movie)
    func setView(movie: Movie)
    func openYoutube(url: String)
    func setVideo(videosList: [Video])
    func setReview(reviewList : [Review])
    
    
}
