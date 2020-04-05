//
//  GenreCollectionViewCell.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 04/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    var viewModel: GenreViewModel? {
        didSet {
            self.updateViews()
        }
    }
    
    override func awakeFromNib() {
        layer.masksToBounds = false
        layer.cornerRadius = 32.0
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2.0
    }
    
    // Helpers
    
    func updateViews() {
        self.label.text = self.viewModel?.displayText
    }
}
