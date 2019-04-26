//
//  VideoListScreen.swift
//  TrailerAppHugoDeGroot500755313
//
//  Created by Wim de Groot on 22/04/2019.
//  Copyright © 2019 Wim de Groot. All rights reserved.
//

import UIKit

class VideoListScreen: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var videos: [Video] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()

        fetchTrailerJSON { (res) in
            switch res {
            case .success(let videos):
                self.videos = videos
                DispatchQueue.main.async { // Correct
                    self.tableView.reloadData()
                }
            case .failure(let err):
                print("Failed to fetch trailers", err)
            }
        }
        
        
        
//        fetchTrailerJSON { (videos, err) in
//            if let err = err {
//                print("Failed to fetch trailers", err)
//                return
//            }
//
//            videos?.forEach({ (video) in
//                print(video.title)
//            })
//        }
        
        }
    
    private func setupTableView() {
        tableView?.register(TrailerTableViewCell.nib, forCellReuseIdentifier: TrailerTableViewCell.identifier)
        tableView?.delegate = self
        tableView?.dataSource = self
        //        tableView.separatorStyle = .none
        //        tableView.backgroundColor = .black
        //        tableView.addSubview(self.refreshControl)
    }
    

    

    
    fileprivate func fetchTrailerJSON(completion: @escaping (Result<[Video], Error>) -> ()) {
        
        let urlString = "https://appstubs.triple-it.nl/trailers/"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(.failure(err))
                //completion(nil, err)
                return
            }
            
            // successfull
            do {
                let videos = try JSONDecoder().decode([Video].self, from: data!)
                completion(.success(videos))
                //completion(videos, nil)
            } catch let jsonError {
                completion(.failure(jsonError))
                //completion(nil, jsonError)
            }
            
            
            
        }.resume()
        
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}

extension VideoListScreen: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let video = videos[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrailerTableViewCell.identifier, for: indexPath) as? TrailerTableViewCell else { return UITableViewCell() }
        cell.setVideo(video: video)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTrailer = videos[indexPath.row]
        
        let destinationVC = InfoViewController()
        show(destinationVC, sender: self)
        
    }
}
