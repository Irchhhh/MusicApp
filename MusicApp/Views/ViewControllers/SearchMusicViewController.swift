//
//  SearchViewController.swift
//  MusicApp
//
//  Created by Ирина on 28.02.2022.
//

import UIKit
import Alamofire

struct TrackModel {
    var trackName: String
    var artistName: String
}

class SearchMusicViewController: UITableViewController {
    var tracks = [Track]()
    var networkService = NetworkService()
    let searchBarController = UISearchController(searchResultsController: nil)
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
        
        setupSearchBar()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        let tracks = tracks[indexPath.row]
        
        cell.textLabel?.text = "\(tracks.trackName) \(tracks.artistName)"
        cell.textLabel?.numberOfLines = 2
        cell.imageView?.image = #imageLiteral(resourceName: "Search")
        
        return cell
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchBarController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchBarController.searchBar.delegate = self

    }
}

extension SearchMusicViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print(searchText)
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.networkService.fetchTracks(searchText: searchText) { [weak self] searchResults in
                self?.tracks = searchResults?.results ?? []
                self?.tableView.reloadData()
            }
        })
    }
}


