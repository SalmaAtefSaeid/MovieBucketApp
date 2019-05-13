//
//  NetworkConnection.swift
//  MovieBucket
//
//  Created by JETS Mobile Lab-12 on 5/13/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import Foundation
import Alamofire

class NetworkConnection{
    
    init() {
        Alamofire.request("https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=f19893f85426e33ad5ea2a0301b009b9").responseJSON{
            response in
            if let json = response.result.value  {
                print(json)
            }
        }
    }
    
}
