//
//  FavouriteDelegate.swift
//  MovieBucket
//
//  Created by Esraa Hassan on 5/17/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import Foundation

protocol FavouritePresenterDelegate
{
    func fetchMovies (delegate: AppDelegate)
    func setDelegate(delegate: FavouriteVCDelegate)
    
}
