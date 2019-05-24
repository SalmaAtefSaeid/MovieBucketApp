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

class ViewController: UIViewController , ViewControllerDelegete, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

   
    var moviesList :[Movie]?
    var movieSelected : Movie?
    var homePresenter : HomePresenter = HomePresenter()
    @IBOutlet var collection: UICollectionView!
    let segmentedControl = UISegmentedControl(items: ["Most popular", "Top rated"])
    var url: String = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=f19893f85426e33ad5ea2a0301b009b9"
    var moviesArray = [Movie]()
    let color = Color()
    var estimateWidth = 160.0
    var cellMarginSize = 16.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        moviesList = []
        collection.delegate = self
        collection.dataSource = self
        self.homePresenter.setDelegete(delegete: self)
        homePresenter.startConnection(url: url)
        segmentedControl.sizeToFit()
        segmentedControl.tintColor = Color.darkOrange
//        segmentedControl.setGradientBackground(colorOne: Color.darkOrange, colorTwo: Color.lightOrange)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(self.selectViewBy(_:)), for: .valueChanged)
        self.navigationItem.titleView = segmentedControl
//        view.setGradientBackground(colorOne: Color.darkOrange, colorTwo: Color.lightOrange)
//        collection.setGradientBackground(colorOne: Color.darkOrange, colorTwo: Color.lightOrange)
        setupGridView()
    }
    
    func setMovie(moviesList: [Movie]) {
        self.moviesList = moviesList
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
//         cell.movieImageView.sd_setImage(with: URL(string: moviesList![indexPath.row].myImage), placeholderImage: UIImage(named: "tangled.jpg"))
        Alamofire.request(self.moviesList![indexPath.row].myImage).responseImage { response in
            if let image = response.result.value {
                cell.movieImageView.image = image
            }
        }
//        cell.movieImageView.image = UIImage.init(data: moviesList![indexPath.row].myImage)
        return cell
    }
    @IBAction func selectViewBy(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            url = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=f19893f85426e33ad5ea2a0301b009b9"
            homePresenter.startConnection(url: url)
        case 1 :
            url = "https://api.themoviedb.org/3/discover/movie?sort_by=top_rated.desc&api_key=f19893f85426e33ad5ea2a0301b009b9"
            homePresenter.startConnection(url: url)
        default:
            break
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieSelected = moviesList![indexPath.row]
        
        let movieDetailsVC: MovieDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "movieDetails") as! MovieDetailsViewController
        movieDetailsVC.movieDetailsPresenter.setDelegete(delegete: movieDetailsVC)
        movieDetailsVC.movieDetailsPresenter.passMovieDetails(movie: movieSelected!)
        //homePresenter.sendMovieDetails(movie: movieSelected!)
        self.navigationController?.pushViewController(movieDetailsVC, animated:false)
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        segue.destination.restorationIdentifier = "movieDetails"
//        segue.destination as! MovieDetailsViewController
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        let width = (self.view.frame.size.width - 8 * 2) / 2
////        let height = width * 275 / 185
////        return CGSize(width: width, height: height)
//        let width = self.calculateWith()
//        let height = width * 275 / 185
//        return CGSize(width: width, height: height)
//    }
    
    func setupGridView() {
        let flow = collection.collectionViewLayout as! UICollectionViewFlowLayout
        let width = (self.collection.frame.size.width - 20 )/2
        let height = width * 275 / 185
        flow.itemSize = CGSize(width: width, height: height)
        flow.minimumInteritemSpacing = CGFloat(0)
        flow.minimumLineSpacing = CGFloat(5)
    }
}


