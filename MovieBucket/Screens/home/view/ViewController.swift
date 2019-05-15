//
//  ViewController.swift
//  MovieBucket
//
//  Created by Esraa Hassan on 5/12/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController , ViewControllerDelegete, UICollectionViewDelegate, UICollectionViewDataSource {

   
    var moviesList :[Movie]?
    var homePresenter : HomePresenter = HomePresenter()
    @IBOutlet var choicesCollection: [UIButton]!
    @IBOutlet var collection: UICollectionView!
    var moviesArray = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        moviesList = []
        collection.delegate = self
        collection.dataSource = self
        self.homePresenter.setDelegete(delegete: self)
        homePresenter.startConnection(url:"https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=f19893f85426e33ad5ea2a0301b009b9")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sortBtn(_ sender: UIButton) {
        choicesCollection.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations:{
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()

            })
                    }
    }
    
    enum choices  :  String
    {
        case mostPopular = "mostPopular"
        case HighestRate = "rate"
    }
    
    @IBAction func selectedChoices(_ sender: UIButton) {
        guard let title = sender.currentTitle , let menuChoice = choices(rawValue:title)
            else{
            return
        }
        switch menuChoice {
            
        case .mostPopular :
            print("populaaaar")
        default:
            print("highestRate")
        }
    }
    func setMovie(moviesList: [Movie]) {
        self.moviesList = moviesList
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : ImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
         cell.movieImageView.sd_setImage(with: URL(string: "​https://image.tmdb.org/t/p/w185//svIDTNUoajS8dLEo7EosxvyAsgJ.jpg"), placeholderImage: UIImage(named: "tangled.jpg"))
        print(moviesList![indexPath.row].myImage)
//        cell.movieImageView.image = UIImage.init(data: moviesList![indexPath.row].myImage)
        return cell
    }
    
}

