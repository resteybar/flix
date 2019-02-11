//
//  MovieGridViewController.swift
//  Alamofire
//
//  Created by Raymond Esteybar on 2/5/19.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collection_view: UICollectionView!
    
    var movies = [[String: Any]]() // Array of dictionaries
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection_view.delegate = self
        collection_view.dataSource = self
        
        let layout = collection_view.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 4          // Row spacing
        layout.minimumInteritemSpacing = 4     // Column spacing
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        layout.itemSize = CGSize(width: width, height: width * 1.5)
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1")!
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
                
                self.collection_view.reloadData()
                
                print(self.movies)
            }
        }
        task.resume()
    }
    
    // # of movies
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    // Movie info
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection_view.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = movies[indexPath.item] // Index Path don't use rows, use items
        
        let base_url = "https://image.tmdb.org/t/p/w185"
        let poster_path = movie["poster_path"] as! String
        let poster_url = URL(string: base_url + poster_path)
        
        cell.poster_view.af_setImage(withURL: poster_url!)
        
        return cell
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
