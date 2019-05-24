//
//  FavouriteViewController.swift
//  MovieBucket
//
//  Created by JETS Mobile Lab-3 on 5/14/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class FavouriteViewController: UIViewController, FavouriteVCDelegate, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet var favouriteCollectionView: UICollectionView!
    var favouritePresenter : FavouritePresenterDelegate = FavouritePresenter()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var moviesList = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favouriteCollectionView.dataSource = self
        favouriteCollectionView.delegate = self
        favouritePresenter.setDelegate(delegate: self)
        favouritePresenter.fetchMovies(delegate: appDelegate)
    }
    func setMovies(movieList: [Movie]) {
        moviesList = movieList
        DispatchQueue.main.async {
             self.favouriteCollectionView.reloadData()
        }
       
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : FavouriteCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as! FavouriteCollectionViewCell
        let movieImageUrl = moviesList[indexPath.row].myImage as! String
        Alamofire.request(movieImageUrl).responseImage { response in
            if let image = response.result.value {
                cell.movieImage.image = image
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var movieSelected = moviesList[indexPath.row]
        var movieDetailsVC: MovieDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "movieDetails") as! MovieDetailsViewController
        movieDetailsVC.movieDetailsPresenter.setDelegete(delegete: movieDetailsVC)
        movieDetailsVC.movieDetailsPresenter.passMovieDetails(movie: movieSelected)
        self.navigationController?.pushViewController(movieDetailsVC, animated:false)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 8 * 2) / 2
        let height = width * 275 / 185
        //        let padding: CGFloat =  50
        //        let collectionViewSize = collectionView.frame.size.width - padding
        //        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
        return CGSize(width: width, height: height)
    }
//    func populateMovie(movie: NSManagedObject) -> Movie{
//        
//        var movie = Movie(movieId: movie.value(forKey: "movieID") as! Int32 , title: movie.value(forKey: "title") as! String, myImage: movie.value(forKey: "myImage") as! String, description: movie.value(forKey: "movieDescription") as! String, releaseDate: movie.value(forKey: "releaseDate") as! String, userRating: movie.value(forKey: "userRating") as! Int32)
//        return movie
//    }
    
}
