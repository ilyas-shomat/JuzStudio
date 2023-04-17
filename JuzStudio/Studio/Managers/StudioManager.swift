//
//  StudioMainViewModel.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 22.02.2023.
//

import Foundation
import AVFoundation

final class StudioManager {
    var scene: StudioSceneDelegate? {
        didSet {
            scene?.setAmplitudesList(audioManager.getSoundAmplitudes())
        }
    }
    
    private let superpoweredService: SuperpoweredService
    private let audioManager: AudioManager
    private let audioFileUrl: String
    
    init(
        audioFileUrl: String,
        superpoweredService: SuperpoweredService,
        audioManager: AudioManager
    ) {
        self.audioFileUrl = audioFileUrl
        self.superpoweredService = superpoweredService
        self.audioManager = audioManager
        
        self.audioManager.audiosUrlsString.append(audioFileUrl)
        
        superpoweredService.setupMainPlayer(withPath: audioFileUrl)
        
//        superpoweredService.audioCompletion = { [weak self] in
//            self?.viewController?.mainAudioPlayingFinished()
//        }
        
        superpoweredService.audioCompletion = self.scene?.mainAudioPlayingFinished
    }
}

extension StudioManager: StudioManagerDelegate {
    func onPlayPause() {
        superpoweredService.onPlayPause()
    }
}
