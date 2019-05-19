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
    
    @IBOutlet var myScrollView: UIScrollView!
    @IBOutlet var reviewTable: UITableView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieVote: UILabel!
    @IBOutlet var movieOverview: UITextView!
    @IBOutlet var dateTitle: UILabel!
    @IBOutlet var trailersTableView: UITableView!
    var movieDetailsPresenter: MovieDetailsDelegate = MovieDetailsPresenter()
    var selectedMovie: Movie?
    var videoList = [Video]()
    var reviewList = [Review]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trailersTableView.delegate = self
        trailersTableView.dataSource = self
        reviewTable.delegate = self
        reviewTable.dataSource = self
        setView(movie: selectedMovie!)
        myScrollView.isScrollEnabled = true
        myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 700)
    }
    
    func setMovieDetails(movie: Movie) {
        selectedMovie = movie
    }
    
    func setView(movie: Movie){
        var title = movie.title
        movieTitle.text = title
        movieOverview.text = movie.description
        dateTitle.text = movie.releaseDate
        movieVote.text=String(movie.userRating)+"/10"
        var img = movie.myImage
        Alamofire.request(img).responseImage { response in
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
            var cell : TrailerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "trailerCell", for: indexPath) as! TrailerTableViewCell
            cell.videoName.text = videoList[indexPath.row].videoName
            return cell
        case reviewTable:
            var cell : ReviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewTableViewCell
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
    
    @IBAction func favouriteMovie(_ sender: UIButton) {
        movieDetailsPresenter.setFavouriteMovie(degelate: appDelegate, movie: selectedMovie!)
    }
    func openYoutube(url: String){
        let appUrl = NSURL(string: "youtube://www.youtube.com/watch?v=\(url)")
        let webUrl = NSURL(string: "https://www.youtube.com/watch?v=\(url)")
        let application = UIApplication.shared
        if application.canOpenURL(appUrl! as URL){
            application.open(appUrl! as URL, options: [:], completionHandler: nil)
        }else{
            application.open(webUrl! as URL, options: [:], completionHandler: nil)
            print(webUrl)
        }
    }
    func setVideo(videosList: [Video]) {
        videoList = videosList
        trailersTableView.reloadData()
    }
    func setReview(reviewList: [Review]) {
        self.reviewList = reviewList
        reviewTable.reloadData()
    }

}
