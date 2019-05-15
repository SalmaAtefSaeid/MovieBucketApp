//
//  NetworkProtocol.swift
//  MovieBucket
//
//  Created by JETS Mobile Lab-3 on 5/14/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import Foundation
protocol NetworkProtocol {
    
    func connect (url: String)
    func parseJson (moviesList : [[String:Any]]) -> [Movie]
    func setDelegete (delegete: HomeDelegate)
}
