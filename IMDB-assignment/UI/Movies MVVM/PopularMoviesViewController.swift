//
//  PopularMoviesViewController.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 04/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import UIKit
import lit_network

class PopularMoviesViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    /** Screen ViewModel */
    let viewModel = PopularMoviesListViewModel(httpClient: URLSessionHTTPClient())
    
    var selectedGenreName: String = "" {
        didSet {
            viewModel.selectedGenreName = self.selectedGenreName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        
        spinner.startAnimating()
        
        viewModel.delegate = self
        
        loadData()
        
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navBarSetup()
    }
    
    private func registerCell() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 174
        tableView.register(UINib(nibName: "PopularMovieTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularMovieTableViewCell")
    }
    
    private func navBarSetup() {
        navigationController?.navigationBar.topItem?.title = viewModel.screenTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func loadData() {
        viewModel.loadNext()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "PopularMovieTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularMovieTableViewCell")
    }
}

// MARK: ViewModel Delegate
extension PopularMoviesViewController: PopularMoviesListLoaderProtocol {
    func receivedData(_ movies: RemotePopularMoviesLoader.Result) {
        spinner.stopAnimating()
        if case .success = movies {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension PopularMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularMovieTableViewCell") as! PopularMovieTableViewCell
        cell.viewModel = viewModel[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            // Notify interested parties that end has been reached
            viewModel.loadNext()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetails = MovieDetailsViewController()
        movieDetails.viewModel = MovieDetailsViewModel(model: viewModel[indexPath.row].data, http: URLSessionHTTPClient())
        navigationController?.pushViewController(movieDetails, animated: true)
        
        /** Release touch appreance */
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
