//
//  MovieCell.swift
//  MEdiaFinder 2
//
//  Created by nassermac on 5/25/23.
//  Copyright © 2023 Nasser Co. All rights reserved.
//

import UIKit

class ArtistCell: UITableViewCell {

    
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @objc func imageTapped() {
        UIView.animate(withDuration: 0.5, animations: {
            self.artistImage.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.artistImage.transform = CGAffineTransform.identity
            }
        })
    }
    
    
}
