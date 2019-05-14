//
//  ViewController.swift
//  MovieBucket
//
//  Created by Esraa Hassan on 5/12/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    var networkConnection : NetworkConnection?
    @IBOutlet var choicesCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        networkConnection = NetworkConnection()
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
  
}

