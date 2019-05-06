//
//  InfoViewController.swift
//  TrailerAppHugoDeGroot500755313
//
//  Created by Wim de Groot on 24/04/2019.
//  Copyright © 2019 Wim de Groot. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class InfoViewController: UIViewController {
    
    @IBOutlet weak var stillImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var watchButton: UIButton!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    
    
    var selectedTrailer: Video?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedTrailer != nil {setData()}

        // Do any additional setup after loading the view.
    }
    
    func setData() {
        titleLabel.text = selectedTrailer!.title
        let genreString = getGenres(genres: selectedTrailer!.genre)
        genreLabel.text = NSLocalizedString("Genre", comment: "") + genreString
        descriptionLabel.text = selectedTrailer!.description
        watchButton.setTitle(NSLocalizedString("Bekijk trailer", comment: ""), for: .normal)
        shareButton.setTitle(NSLocalizedString("Share", comment: ""), for: .normal)
        
        guard let urlStillImage = URL(string: selectedTrailer!.stillImage) else { return }
        downloadStillImage(from: urlStillImage)
        
        guard let urlPosterImage = URL(string: selectedTrailer!.posterImage) else { return }
        downloadPosterImage(from: urlPosterImage)
        
        

        watchButton.addTarget(self, action: #selector(presentVideo), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareUrl), for: .touchUpInside)
    }
    
    @objc func shareUrl() {
        let items = [URL(string: selectedTrailer!.url)!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @objc func presentVideo() {
        let player = AVPlayer(url: URL(string: selectedTrailer!.url)!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }
    
    func getGenres(genres: [String]) -> String {
        var allGenres = ""
        for gen in genres {
            if(allGenres == "") {
                allGenres = gen
            } else {
                allGenres = allGenres + ", " + gen
            }
        }
        return allGenres
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadStillImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.stillImage.image = UIImage(data: data)
            }
        }
    }
    
    func downloadPosterImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.posterImage.image = UIImage(data: data)
            }
        }
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
