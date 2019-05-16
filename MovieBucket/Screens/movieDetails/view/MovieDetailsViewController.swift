//
//  MovieDetailsViewController.swift
//  MovieBucket
//
//  Created by JETS Mobile Lab-3 on 5/15/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

 
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieOverview: UILabel!
    @IBOutlet var dateTitle: UILabel!
    @IBOutlet var trailersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trailersTableView.delegate = self
        trailersTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    @IBAction func favouriteImage(_ sender: UIButton) {
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
