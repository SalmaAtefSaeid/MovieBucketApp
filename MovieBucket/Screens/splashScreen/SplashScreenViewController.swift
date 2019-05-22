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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgAppIcon.image = UIImage(named: "tangled.jpg")

        // Do any additional setup after loading the view.
        UIView.animate(withDuration: 2.0) {
            self.moveTop(view: self.appName)
        }
        UIView.animate(withDuration: 2.0) {
            self.moveBottom(view: self.imgAppIcon)
        }
//        UIView.animate(withDuration: 2.0, delay: 0, options:[.repeat, .autoreverse], animation:{
//    self.moveTop(view: self.label)
//    })
    }
    
    func moveTop(view: UIView){
        view.center.y -= 350
    }
    func moveBottom(view: UIView){
        view.center.y += 200
    }

}
