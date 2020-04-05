//
//  MovieDetailsViewController.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 05/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overview: UITextView!
    
    var viewModel: MovieDetailsViewModel? {
        didSet {
            self.viewModel?.loadVideos()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBarSetup()
    }
    
    private func navBarSetup() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = viewModel?.screenTitle
    }
    
    private func updateViews() {
        guard let viewModel = viewModel else { return }
        posterImage.sd_setImage(with: viewModel.imageUrl, completed: nil)
        titleLabel.text = viewModel.displayTitle
        dateLabel.text = viewModel.displayDate
        overview.text = viewModel.displayOverview
    }
    
    @IBAction func didTappedPlay(_ sender: UIButton) {
        viewModel?.playVideo()
    }
}
