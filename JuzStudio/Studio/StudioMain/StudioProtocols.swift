//
//  StudioMainProtocols.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 22.02.2023.
//

import Foundation

protocol StudioSceneDelegate {
    var manager: StudioManagerDelegate? { get set }
    
    func setAmplitudesList(_ amplitudesList: [[CGFloat]])
    func mainAudioPlayingFinished()
}

protocol StudioManagerDelegate {
    var scene: StudioSceneDelegate? { get set }
    
    func onPlayPause()
}
