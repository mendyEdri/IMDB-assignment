//
//  PopularMovieTableViewCell.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 04/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import UIKit
import SDWebImage

class PopularMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    var viewModel: PopularMovieViewModel? = nil {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateView() {
        guard let viewModel = viewModel else { return }
        title.text = viewModel.displayTitle
        if viewModel.shouldBeMarked {
            self.contentView.backgroundColor = .darkGray
        } else {
            self.contentView.backgroundColor = .black
        }
        posterImageView.sd_setImage(with: viewModel.imageUrl, completed: nil)
    }
}

extension UILabel {
    /** change the text color in a label for spesific string */
    @objc func text(color: UIColor, for string: String) {
        appendAttribute(for: string, key: .foregroundColor, value: color)
    }
    
    /** func to ease the handlign of adding additional attribute string to label */
    func appendAttribute(for string: String, key: NSAttributedString.Key, value: Any) {
        guard let text = self.text else {
            return
        }
        let range = text.range(of: string)
        guard let _ = range else { return }
        
        let start = text.distance(from: string.startIndex, to: range!.lowerBound)
        let length = text.distance(from: range!.lowerBound, to: range!.upperBound)
        let nsRange = NSMakeRange(start, length)
        
        let attributedText = NSMutableAttributedString.init(attributedString: self.attributedText ?? NSMutableAttributedString(string: text))
        
        // text attribute
        attributedText.addAttribute(key, value: value, range: nsRange)
        self.attributedText = attributedText
    }
}
