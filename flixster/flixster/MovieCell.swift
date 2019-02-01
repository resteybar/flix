//
//  MovieCell.swift
//  flixster
//
//  Created by Raymond Esteybar on 1/30/19.
//  Copyright © 2019 Raymond Esteybar. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var title_label: UILabel!
    @IBOutlet weak var synopsis_label: UILabel!
    @IBOutlet weak var poster_view: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
