//
//  HomePresenter.swift
//  MovieBucket
//
//  Created by JETS Mobile Lab-3 on 5/14/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import Foundation
class HomePresenter : HomeDelegate {
    
    var networkConnection : NetworkConnection = NetworkConnection()
    var viewController : ViewController?
    init() {
        self.networkConnection.setDelegete(delegete: self)
    }
    func setDelegete(delegete: ViewController) {
        self.viewController = delegete
    }
    func startConnection(url: String) {
        networkConnection.connect(url: url)
    }
    
    func fetchMovie(moviesList: [Movie]) {
        viewController?.setMovie(moviesList: moviesList)
    }
}
