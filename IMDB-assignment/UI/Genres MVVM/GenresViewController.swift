//
//  GenresViewController.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 04/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import UIKit

class GenresViewController: UIViewController {
    
    /** Views */
    @IBOutlet weak var collectionView: UICollectionView!
    
    /** View Model */
    private let viewModel = GenresListViewModel()
    
    /** Loading Sequence */
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("GenresViewController")
        
        registerCell()
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // Helpers
    
    private func registerCell() {
        collectionView.register(UINib(nibName: "GenreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GenreCollectionViewCell")
    }
    
    private func loadData() {
        viewModel.loadGenres { [weak self] result in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    var canceled = false
}

extension GenresViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as! GenreCollectionViewCell
        cell.viewModel = viewModel[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let popularMovieList = PopularMoviesViewController()
        navigationController?.pushViewController(popularMovieList, animated: true)
    }
}
