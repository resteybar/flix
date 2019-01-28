//
//  ViewController.swift
//  flixster
//
//  Created by Raymond Esteybar on 1/28/19.
//  Copyright © 2019 Raymond Esteybar. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Outlets
    @IBOutlet weak var table_view: UITableView!
    
    // Properties
    var movies = [[String: Any]]() // Array of dictionaries
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table_view.dataSource = self
        table_view.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        print("Hello")
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                // TODO: Get the array of movies
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                //                print(dataDictionary)
                
                // TODO: Store the movies in a property to use elsewhere
                self.movies = dataDictionary["results"] as! [[String: Any]] // Cast as an Array of dictionaries
                
                // TODO: Reload your table view data
                self.table_view.reloadData()
            }
        }
        task.resume()
    }


    // Amount of Movies
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    // Movie Information
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        
        cell.textLabel?.text = title
        
        return cell
    }
}

