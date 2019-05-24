//
//  MovieDetailsViewController.swift
//  MovieBucket
//
//  Created by JETS Mobile Lab-3 on 5/15/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MovieDetailsViewControllerDelegate{
   
    
    
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet var myScrollView: UIScrollView!
    @IBOutlet var reviewTable: UITableView?
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieVote: UILabel!
    @IBOutlet var movieOverview: UITextView!
    @IBOutlet var dateTitle: UILabel!
    @IBOutlet var trailersTableView: UITableView!
    @IBOutlet var titleView: UIView!
    @IBOutlet var overviewView: UIView!
    @IBOutlet var reviewView: UIView!
    @IBOutlet var trailerView: UIView!
    var movieDetailsPresenter: MovieDetailsDelegate = MovieDetailsPresenter()
    
    
    var selectedMovie: Movie?
    var videoList = [Video]()
    var reviewList = [Review]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trailersTableView?.delegate = self
        trailersTableView?.dataSource = self
        reviewTable?.delegate = self
        reviewTable?.dataSource = self
        
        setView(movie: selectedMovie!)
        myScrollView.isScrollEnabled = true
        myScrollView.contentSize = CGSize(width: self.view.frame.width, height: 1000)
        movieDetailsPresenter.isFavourite(movie: selectedMovie!, delegate: appDelegate)
        titleView.setGradientBackground(colorOne: Color.darkOrange, colorTwo: Color.lightOrange)
        overviewView.setGradientBackground(colorOne: Color.darkOrange, colorTwo: Color.lightOrange)
        trailerView.setGradientBackground(colorOne: Color.darkOrange, colorTwo: Color.lightOrange)
        reviewView.setGradientBackground(colorOne: Color.darkOrange, colorTwo: Color.lightOrange)
    }
    
    
    func setMovieDetails(movie: Movie) {
        selectedMovie = movie
        
    }
    func showAlert(){
        let alert = UIAlertController(title: "Please turn on wifi or cellular data", message: "It's recommended you turn on  before wifi or cellular data continuing.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    func setMovieAsFavourite(isAlreadyExist : Bool) {
        if( isAlreadyExist == true )
        {
            favouriteBtn.setTitleColor(Color.golden, for: .normal)
            
        }
        else
        {
             favouriteBtn.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    func setView(movie: Movie){
        movieTitle.text = movie.title
        movieOverview.text = movie.description
        dateTitle.text = movie.releaseDate
        movieVote.text=String(movie.userRating)+"/10"
        Alamofire.request(movie.myImage).responseImage { response in
            if let image = response.result.value {
                self.movieImage.image = image
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case trailersTableView:
             return (videoList.count)
        case reviewTable:
            return(reviewList.count)
        default:
            return 0
        }
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        
        case trailersTableView:
            let cell : TrailerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "trailerCell", for: indexPath) as! TrailerTableViewCell
            cell.videoName.text = videoList[indexPath.row].videoName
            cell.imageView?.image = UIImage(named: "icons8-play-button-100.png")
            return cell
        case reviewTable:
            let cell : ReviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewTableViewCell
            cell.reviewAuthor.text = reviewList[indexPath.row].author
            cell.reviewContent.text=reviewList[indexPath.row].content
            return cell
        default:
            var cell: UITableViewCell = UITableViewCell()
            return cell
            
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case trailersTableView:
            openYoutube(url: videoList[indexPath.row].videoID)
        case reviewTable:
           print(reviewList[indexPath.row].author)
        default:
            print("")
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @IBAction func favouriteMovie(_ sender: UIButton) {
      
       
       if(sender.currentTitleColor==UIColor.yellow)
        {
            movieDetailsPresenter.deleteFavouriteMovie(degelate: appDelegate, movie: selectedMovie!)
            sender.setTitleColor(UIColor.white, for: .normal)
            
        }
        else if (sender.currentTitleColor==UIColor.white)
        {
             movieDetailsPresenter.setFavouriteMovie(degelate: appDelegate, movie: selectedMovie!)
             sender.setTitleColor(UIColor.yellow, for: .normal)
        }
       
        
    }
    func openYoutube(url: String){
        let appUrl = NSURL(string: "youtube://www.youtube.com/watch?v=\(url)")
        let webUrl = NSURL(string: "https://www.youtube.com/watch?v=\(url)")
        let application = UIApplication.shared
        if application.canOpenURL(appUrl! as URL){
            application.open(appUrl! as URL, options: [:], completionHandler: nil)
        }else{
            application.open(webUrl! as URL, options: [:], completionHandler: nil)
        }
    }
    func setVideo(videosList: [Video]) {
        videoList = videosList
        DispatchQueue.main.async {
            self.trailersTableView?.reloadData()
        }
        
    }
    func setReview(reviewList: [Review]) {
        self.reviewList = reviewList
        DispatchQueue.main.async {
            self.reviewTable?.reloadData()
        }
        
    }

}
