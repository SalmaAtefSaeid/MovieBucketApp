//
//  MovieDetailsPresenter.swift
//  MovieBucket
//
//  Created by JETS Mobile Lab-12 on 5/16/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import Foundation
import CoreData

class MovieDetailsPresenter: MovieDetailsDelegate {
    
    var homeDelegate : HomeDelegate?
    var movieDetailsVCDelegate: MovieDetailsViewControllerDelegate?
    var favouritePresenter : FavouritePresenterDelegate = FavouritePresenter()
     var network : NetworkProtocol = NetworkConnection()
    
    
    
    init() {
//        movieDetailsVCDelegate.setDelegate(delegete: self)
        network.setMovieDetailsDelegete(delegete: self)
    }
    
    func setDelegete(delegete: MovieDetailsViewControllerDelegate) {
       movieDetailsVCDelegate = delegete
    }
    func passMovieDetails(movie: Movie) {
        movieDetailsVCDelegate!.setMovieDetails(movie: movie)
        setTrailer(movie: movie)
        setReview(movie: movie)
    }
    func setTrailer(movie: Movie){
        var movieID = String(movie.movieId)
        network.connectToGetYoutubeID(movieID: movieID)
    }
    func setFavouriteMovie(degelate: AppDelegate, movie : Movie) {
        let managerContext = degelate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: managerContext)
        let storedMovie  = NSManagedObject(entity: entity!, insertInto: managerContext)
        storedMovie.setValue(movie.title, forKey: "title")
        storedMovie.setValue(movie.userRating, forKey: "userRating")
        storedMovie.setValue(movie.releaseDate, forKey: "releaseDate")
        storedMovie.setValue(movie.movieId, forKey: "movieID")
        storedMovie.setValue(movie.myImage, forKey: "myImage")
        storedMovie.setValue(movie.description, forKey: "movieDescription")
        do{
            try managerContext.save()
            favouritePresenter.notifyChange(delegate: degelate)
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
        }
        
    }
     func getYoutubeJson (youtubeArrayID : [Video])
     {
        movieDetailsVCDelegate?.setVideo(videosList: youtubeArrayID)
        
    }
    func getReviewJson(reviewArray: [Review]) {
       movieDetailsVCDelegate?.setReview(reviewList: reviewArray)
    }
    func setReview(movie: Movie) {
        var movieID = String(movie.movieId)
        network.connectToGetReview(movieID: movieID)
    }
    func deleteFavouriteMovie(degelate: AppDelegate, movie: Movie) {
        let managerContext = degelate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
        let myPredicate = NSPredicate(format: "movieID == \(movie.movieId)")
        fetchRequest.predicate = myPredicate
        do{
            var movie = try managerContext.fetch(fetchRequest)
            managerContext.delete(movie[0])
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
        }
        
    }
    
    
    
    

    
    
}
