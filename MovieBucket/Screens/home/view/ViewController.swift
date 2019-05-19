//
//  ViewController.swift
//  MovieBucket
//
//  Created by Esraa Hassan on 5/12/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import UIKit
import SDWebImage
import AlamofireImage
import Alamofire

class ViewController: UIViewController , ViewControllerDelegete, UICollectionViewDelegate, UICollectionViewDataSource {

   
    var moviesList :[Movie]?
    var movieSelected : Movie?
    var homePresenter : HomePresenter = HomePresenter()
    @IBOutlet var collection: UICollectionView!
    let segmentedControl = UISegmentedControl(items: ["Most popular", "Top rated"])
    var url: String = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=f19893f85426e33ad5ea2a0301b009b9"
    var moviesArray = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        moviesList = []
        collection.delegate = self
        collection.dataSource = self
        self.homePresenter.setDelegete(delegete: self)
        homePresenter.startConnection(url: url)
        segmentedControl.sizeToFit()
        segmentedControl.tintColor = UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        segmentedControl.selectedSegmentIndex = 0
        self.navigationItem.titleView = segmentedControl
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setMovie(moviesList: [Movie]) {
        self.moviesList = moviesList
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
         cell.movieImageView.sd_setImage(with: URL(string: moviesList![indexPath.row].myImage), placeholderImage: UIImage(named: "tangled.jpg"))
        print(self.moviesList![indexPath.row].myImage)
        var urlMovie : String = self.moviesList![indexPath.row].myImage
//        Alamofire.request("​https://image.tmdb.org/t/p/w185//6sOFQDlkY6El1B2P5gklzJfVdsT.jpg").responseImage { response in
//            debugPrint(response)
//            //print(response.request)
//            //print(response.response)
//            //debugPrint(response.result)
//
//            if let image = response.result.value {
//                //print("image downloaded: \(image)")
//                cell.movieImageView.image = image
//            }
//        }
//        cell.movieImageView.image = UIImage.init(data: moviesList![indexPath.row].myImage)
        return cell
    }
    @IBAction func selectViewBy(_ sender: UIBarButtonItem) {
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            url = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=f19893f85426e33ad5ea2a0301b009b9"
        case 1 :
            url = ""
            
        default:
            break
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieSelected = moviesList![indexPath.row]
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.restorationIdentifier = "movieDetails"
        homePresenter.sendMovieDetails(movie: movieSelected!)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
}

