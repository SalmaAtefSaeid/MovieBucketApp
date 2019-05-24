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
        fetchRequest.predicate = NSPredicate(format: "movieID == %i" ,(movie.movieId))
        do{
            let fetchedMovie = try managerContext.fetch(fetchRequest)
            for item in fetchedMovie{
                managerContext.delete(item)
            }
            try  managerContext.save()
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
        }
        
    }
    func fetchData(delegate: AppDelegate) {
        let managerContext = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
        do{
            var movies = Array <Movie>()
            movies = populateMovie(moviesList: try managerContext.fetch(fetchRequest))
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
        }
    }
    func populateMovie(moviesList: [NSManagedObject]) -> [Movie] {
        
        var moviesArray = [Movie]()
        for movie in moviesList{
            var movie = Movie(movieId: movie.value(forKey: "movieID") as! Int32 , title: movie.value(forKey: "title") as! String, myImage: movie.value(forKey: "myImage") as! String, description: movie.value(forKey: "movieDescription") as! String, releaseDate: movie.value(forKey: "releaseDate") as! String, userRating: movie.value(forKey: "userRating") as! Int32)
            moviesArray.append(movie)
        }
        return moviesArray
    }
    func isFavourite(movie: Movie , delegate : AppDelegate) {
        var checkExist : Bool = false
        let managerContext = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
        do{
            var movies = Array <Movie>()
            movies = populateMovie(moviesList: try managerContext.fetch(fetchRequest))
            for newMovie in movies
            {
                if(newMovie.movieId == movie.movieId )
                {
                    isMovieExist(isExist: true)
                    checkExist = true
                }
            }
            if checkExist == false
            {
                isMovieExist(isExist: false)
            }
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
        }
    }
    func isMovieExist (isExist : Bool)
    {
        movieDetailsVCDelegate?.setMovieAsFavourite(isAlreadyExist : isExist)
    }
    

    
    
    
    
    
    

    
    
}
