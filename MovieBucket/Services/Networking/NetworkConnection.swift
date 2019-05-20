//
//  NetworkConnection.swift
//  MovieBucket
//
//  Created by JETS Mobile Lab-12 on 5/13/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import Foundation
import Alamofire

class NetworkConnection : NetworkProtocol{

 
    var homeDelegete : HomeDelegate?
    var movieDetailsPresenter : MovieDetailsDelegate?
    
    func setDelegete (delegete: HomeDelegate){
        self.homeDelegete = delegete
    }
    func setMovieDetailsDelegete(delegete: MovieDetailsDelegate){
        self.movieDetailsPresenter = delegete
    }
    func connect(url: String)  {
       var moviesArray : [Movie]?
        Alamofire.request(url).responseJSON{
            response in
            if let json = response.result.value as! [String:Any]?
            {
                let movies = json["results"] as! [[String:Any]]?
                moviesArray = self.parseJson(moviesList: movies!)
                self.homeDelegete?.fetchMovie(moviesList: moviesArray!)
            }
        }
    }
    
    func parseJson(moviesList: [[String : Any]]) -> [Movie]{
//        var imageData: Data?
        var moviesArray = [Movie]()
        for movie in moviesList
        {
            let imageStringPath = "http://image.tmdb.org/t/p/w185\(movie["poster_path"] ?? "")"
//            Alamofire.request(imageStringPath).responseData { response in
//                if let data = response.data {
//                   // print(data)
//                    imageData = data
//
//                }
//            }
//            Alamofire.download(imageStringPath)
//                .downloadProgress { progress in
//                    print("Download Progress: \(progress.fractionCompleted)")
//                }
//                .responseData { response in
//                    if let data = response.result.value {
//                        imageData = data
//                    }
//            }
            let newMovie = Movie (movieId: movie["id"] as! Int32, title: movie["original_title"] as! String, myImage: imageStringPath , description: movie["overview"] as! String, releaseDate: movie["release_date"] as! String, userRating: Int32(movie["vote_average"] as! NSNumber))
            moviesArray.append(newMovie)
            
            
        }
        return moviesArray
        
    }
    func connectToGetYoutubeID(movieID: String) {
        var url = "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=f19893f85426e33ad5ea2a0301b009b9"
        var youtubeIDArray : [Video]?
        Alamofire.request(url).responseJSON{
            response in
            if let json = response.result.value as! [String:Any]?
            {
                let youtubeJson = json["results"] as! [[String:Any]]?
                youtubeIDArray = self.parseYoutubeID(json:youtubeJson!)
                
                self.movieDetailsPresenter?.getYoutubeJson(youtubeArrayID: youtubeIDArray!)
                
            }
            
        }
    }
     func parseYoutubeID (json : [[String:Any]]) -> [Video]
     {
        var youtubeIDs = [Video]()
        for video in json
        {
           
            let newVideo = Video (videoID: video["key"] as! String, videoName: video["name"] as! String)
            youtubeIDs.append(newVideo)
            
        }
        return youtubeIDs
    }
    func connectToGetReview(movieID: String) {
        var url = "https://api.themoviedb.org/3/movie/\(movieID)/reviews?api_key=f19893f85426e33ad5ea2a0301b009b9"
        var reviewsArray : [Review]?
        Alamofire.request(url).responseJSON{
            response in
            if let json = response.result.value as! [String:Any]?
            {
                let reviewJson = json["results"] as! [[String:Any]]?
                reviewsArray = self.parseReview(json: reviewJson!)
                    self.movieDetailsPresenter?.getReviewJson(reviewArray: reviewsArray!)
                
            }
            
        }
    }
    
    func parseReview(json: [[String : Any]]) -> [Review] {
        var reviewList = [Review]()
        for review in json
        {
           
            let newReview = Review (author: review["author"] as! String, content: review["content"] as! String)
            reviewList.append(newReview)
            
        }
        return reviewList
    }
}
