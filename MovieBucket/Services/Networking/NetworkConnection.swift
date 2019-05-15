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
    func setDelegete (delegete: HomeDelegate){
        self.homeDelegete = delegete
    }
    func connect(url: String)  {
       var moviesArray : [Movie]?
        Alamofire.request(url).responseJSON{
            response in
            if let json = response.result.value as! [String:Any]?
            {
                let movies = json["results"] as! [[String:Any]]?
                print(movies?[0]["title"])
                moviesArray = self.parseJson(moviesList: movies!)
               
                self.homeDelegete?.fetchMovie(moviesList: moviesArray!)
                
            }
        
        }
    }
    
    func parseJson(moviesList: [[String : Any]]) -> [Movie]{
        var imageData: Data?
        var moviesArray = [Movie]()
        for movie in moviesList
        {
            //print (movie["poster_path"] )
            
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
            let img = movie["poster_path"] as! String
            let imageStringPath = "​http://image.tmdb.org/t/p/w185/" + img
            let newMovie = Movie (title: movie["original_title"] as! String, myImage: imageStringPath as! String, description: movie["overview"] as! String, releaseDate: movie["release_date"] as! String)
            moviesArray.append(newMovie)
            
            
        }
        return moviesArray
        
    }
    func downloadImage (url: String){
        
        
    }
}
