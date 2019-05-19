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
    var movies = Array <NSManagedObject>()
    func setDelegate(delegate: FavouriteVCDelegate) {
        favouriteVC = delegate
    }
    
    func fetchMovies (delegate: AppDelegate){
        let managerContext = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
        do{
            movies = try managerContext.fetch(fetchRequest)
            favouriteVC?.setMovies(movieList: movies)
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
        }
    }
    
    
}
