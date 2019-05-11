//
//  TrailerTableViewCell.swift
//  TrailerAppHugoDeGroot500755313
//
//  Created by Wim de Groot on 23/04/2019.
//  Copyright © 2019 Wim de Groot. All rights reserved.
//

import UIKit

class TrailerTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var trailerImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    func setVideo(video: Video) {
        
        let url = URL(string: video.posterImage)!
        downloadImage(from: url)
        print("End of code. The image will continue downloading in the background and it will be loaded when it ends.")
        
        titleLabel.text = video.title
        descriptionLabel.text = video.description
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.trailerImage.image = UIImage(data: data)
            }
        }
    }
    
    
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
