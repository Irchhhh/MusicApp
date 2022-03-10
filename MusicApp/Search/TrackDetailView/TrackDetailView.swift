//
//  TrackDetailView.swift
//  MusicApp
//
//  Created by Ирина on 07.03.2022.
//

import UIKit
import SDWebImage
import AVKit

class TrackDetailView: UIView {
    @IBOutlet weak var playPauseButton: UIButton!
    
    @IBOutlet weak var authorTitleLabel: UILabel!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    @IBOutlet weak var currentTimeSlider: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBOutlet weak var trackImageView: UIImageView!
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let scale: CGFloat = 0.8

        trackImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        trackImageView.layer.cornerRadius = 5
    }
    
    @IBAction func handleVolumeSlider(_ sender: Any) {
    }
    
    @IBAction func handleCurrentTimeSlider(_ sender: Any) {
    }
    
    @IBAction func dragDownButtonTapped(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    @IBAction func previousTrack(_ sender: Any) {
    }
    
    @IBAction func nextTrack(_ sender: Any) {
    }
    @IBAction func playPauseAction(_ sender: Any) {
        if player.timeControlStatus == .paused {
            player.play()
            playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        } else {
            player.pause()
            playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
    }
                            
    func set(viewModel: SearchViewModel.Cell) {
        trackTitleLabel.text = viewModel.trackName
        authorTitleLabel.text = viewModel.artistName
        playTrack(previewUrl: viewModel.previewUrl)
        
        let string600 = viewModel.iconUrlString?.replacingOccurrences(of: "100x100", with: "600x600")
        guard let url = URL(string: string600 ?? "") else { return }
        trackImageView.sd_setImage(with: url, completed: nil)
    }
    
    private func playTrack(previewUrl: String?) {
        guard let url = URL(string: previewUrl ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    private func enlargeTrackImageView() {
        
    }
}
