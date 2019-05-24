//
//  HomeDelegate.swift
//  MovieBucket
//
//  Created by JETS Mobile Lab-3 on 5/14/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import Foundation

protocol HomeDelegate {
    
    func startConnection(url: String)
    func fetchMovie(moviesList: [Movie])
    func setDelegete(delegete: ViewController)
    func sendMovieDetails(movie : Movie)
    func sendError()
}
