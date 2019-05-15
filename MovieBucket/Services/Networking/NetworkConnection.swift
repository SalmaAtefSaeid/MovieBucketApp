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
    var imageStringPath : String = "​http://image.tmdb.org/t/p/w185/"
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
            
             imageStringPath.append(contentsOf: movie["poster_path"] as! String)
            
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
            let newMovie = Movie (title: movie["original_title"] as! String, myImage: imageStringPath as! String, description: movie["overview"] as! String, releaseDate: movie["release_date"] as! String)
            moviesArray.append(newMovie)
            
            
        }
        return moviesArray
        
    }
    func downloadImage (url: String){
        
        
    }
}
