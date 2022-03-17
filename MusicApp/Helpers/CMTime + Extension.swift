//
//  CMTime + Extension.swift
//  MusicApp
//
//  Created by Ирина on 11.03.2022.
//

import Foundation
import AVKit

extension CMTime {
    func toDisplayString() -> String {
        guard !CMTimeGetSeconds(self).isNaN else { return "" }
        
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let timeString = String(format: "%02d:%02d", minutes, seconds)
        
        return timeString
    }
}
