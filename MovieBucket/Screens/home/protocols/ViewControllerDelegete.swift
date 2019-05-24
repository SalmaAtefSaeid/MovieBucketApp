//
//  ViewControllerDelegete.swift
//  MovieBucket
//
//  Created by JETS Mobile Lab-3 on 5/14/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import Foundation

protocol ViewControllerDelegete {
    
    func setMovie (moviesList: [Movie])
    func showAlert()
}
