//
//  TrackCell.swift
//  MusicApp
//
//  Created by Ирина on 04.03.2022.
//

import UIKit

protocol TrackCellViewModel {
    var iconUrlString: String? { get }
    var trackName: String { get }
    var artistName: String { get }
    var collectionName: String { get }
}

class TrackCell: UITableViewCell {
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    
    static let reuseId = "TrackSell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(viewModel: TrackCellViewModel) {
        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
        
        
    }
}
