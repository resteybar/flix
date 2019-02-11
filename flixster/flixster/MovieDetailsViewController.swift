//
//  MovieDetailsViewController.swift
//  
//
//  Created by Raymond Esteybar on 2/5/19.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var backdrop_view: UIImageView!
    @IBOutlet weak var poster_view: UIImageView!
    @IBOutlet weak var title_label: UILabel!
    @IBOutlet weak var synopsis_label: UILabel!
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title_label.text = movie["title"] as? String
        synopsis_label.text = movie["overview"] as? String
        
        title_label.sizeToFit()
        synopsis_label.sizeToFit()
        
        // Poster Photo
        let base_url = "https://image.tmdb.org/t/p/w185"
        let poster_path = movie["poster_path"] as! String
        let poster_url = URL(string: base_url + poster_path)
        
        poster_view.af_setImage(withURL: poster_url!)
        
        // Backdrop Photo
        let backdrop_path = movie["backdrop_path"] as! String
        let backdrop_url = URL(string: "https://image.tmdb.org/t/p/w780" + backdrop_path)
        
        backdrop_view.af_setImage(withURL: backdrop_url!)
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
