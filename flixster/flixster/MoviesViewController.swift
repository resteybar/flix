//
//  ViewController.swift
//  flixster
//
//  Created by Raymond Esteybar on 1/28/19.
//  Copyright © 2019 Raymond Esteybar. All rights reserved.
//

import UIKit
import AlamofireImage

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
        let cell = table_view.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
        cell.title_label.text = title
        cell.synopsis_label.text = synopsis
        
        let base_url = "https://image.tmdb.org/t/p/w185"
        let poster_path = movie["poster_path"] as! String
        let poster_url = URL(string: base_url + poster_path)
        
        cell.poster_view.af_setImage(withURL: poster_url!)
        
        return cell
    }
    
    // For leaving screen, prepare next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Find the selected movie
        let cell = sender as! UITableViewCell
        let index_path = table_view.indexPath(for: cell)!
        let movie = movies[index_path.row]
        
        // Pass the selected movie to the details view controller
        let details_view_controller = segue.destination as! MovieDetailsViewController
        
        details_view_controller.movie = movie
        
        // Deselect row/movie
        table_view.deselectRow(at: index_path, animated: true)
    }
}

