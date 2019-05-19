//
//  ReviewTableViewCell.swift
//  MovieBucket
//
//  Created by JETS Mobile Lab-12 on 5/19/19.
//  Copyright © 2019 Salma. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet var reviewContent: UITextView!
    @IBOutlet var reviewAuthor: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
