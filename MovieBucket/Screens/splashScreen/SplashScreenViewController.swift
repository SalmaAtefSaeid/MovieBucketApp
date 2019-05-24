//
//  SplashScreenViewController.swift
//  MovieBucket
//
//  Created by Salma Atef Saeid on 5/22/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {

    @IBOutlet var imgAppIcon: UIImageView!
    @IBOutlet var appName: UILabel!
    @IBOutlet var popcorn1: UIImageView!
    
    @IBOutlet var popcorn2: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgAppIcon.image = UIImage(named: "popcorn.png")
        popcorn1.image = UIImage(named: "singlePopcorn.jpeg")
        popcorn2.image = UIImage(named: "singlePopcorn.jpeg")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2){
            self.performSegue(withIdentifier: "homeScreen", sender: nil)
        }
        UIView.animate(withDuration: 2.0) {
            self.moveTop(view: self.appName)
        }
        UIView.animate(withDuration: 2.0) {
            self.moveBottom(view: self.imgAppIcon)
        }
        UIView.animate(withDuration: 2.0, delay: 0, options:[.repeat, .autoreverse], animations:{
            self.movePopcornBottom(view: self.popcorn1)
        })        
    }
    func moveTop(view: UIView){
        view.center.y -= 350
    }
    func moveBottom(view: UIView){
        view.center.y += 200
    }
    func movePopcornTop(view: UIView){
        view.center.y -= self.view.frame.size.height
    }
    func movePopcornBottom(view: UIView){
        view.center.y += self.view.frame.size.height
    }
}
