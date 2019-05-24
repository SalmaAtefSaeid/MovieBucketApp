//
//  FavouritePresenter.swift
//  MovieBucket
//
//  Created by Esraa Hassan on 5/17/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import Foundation
import CoreData

class FavouritePresenter : FavouritePresenterDelegate
{
   
    
    var favouriteVC : FavouriteVCDelegate?
    
    func setDelegate(delegate: FavouriteVCDelegate) {
        favouriteVC = delegate
    }
    
    func fetchMovies (delegate: AppDelegate){
        
        let managerContext = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
        do{
            var movies = Array <Movie>()
            movies = populateMovie(moviesList: try managerContext.fetch(fetchRequest))
            favouriteVC?.setMovies(movieList: movies)
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
        }
    }
    func populateMovie(moviesList: [NSManagedObject]) -> [Movie]
    {
        var moviesArray = [Movie]()
        for movie in moviesList{
            var movie = Movie(movieId: movie.value(forKey: "movieID") as! Int32 , title: movie.value(forKey: "title") as! String, myImage: movie.value(forKey: "myImage") as! String, description: movie.value(forKey: "movieDescription") as! String, releaseDate: movie.value(forKey: "releaseDate") as! String, userRating: movie.value(forKey: "userRating") as! Int32)
            moviesArray.append(movie)
        }
        return moviesArray
    }
    
    
    
    
}
