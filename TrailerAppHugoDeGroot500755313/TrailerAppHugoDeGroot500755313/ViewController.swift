//
//  ViewController.swift
//  TrailerAppHugoDeGroot500755313
//
//  Created by Wim de Groot on 21/04/2019.
//  Copyright © 2019 Wim de Groot. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    //geen strings zo
    let cellId = "cellId"
    
    let names = [
        "Amy", "Berend", "Connie", "Doeta", "Evelien"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Trailers"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let name = self.names[indexPath.row]
        
        cell.textLabel?.text = name
        
        cell.textLabel?.text = "\(name) Section:\(indexPath.section) Row:\(indexPath.row)"
        
        return cell
    }


}

