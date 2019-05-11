//
//  VideoCell.swift
//  TrailerAppHugoDeGroot500755313
//
//  Created by Wim de Groot on 22/04/2019.
//  Copyright © 2019 Wim de Groot. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {

    @IBOutlet weak var trailerImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    func setVideo(video: Video) {
 
        titleLabel.text = video.title
        descriptionLabel.text = video.description
    }
    
    
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    

}
