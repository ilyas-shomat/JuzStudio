//
//  StudioMainProtocols.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 22.02.2023.
//

import Foundation

protocol StudioMainViewControllerDelegate {
    var viewModel: StudioMainViewModelDelegate? { get set }
    
    func setFirstAmplitudes(_ amplitudes: [Float])
    func mainAudioPlayingFinished()
}

protocol StudioMainViewModelDelegate {
    var viewController: StudioMainViewControllerDelegate? { get set }
    
    func onPlayPause()
}
