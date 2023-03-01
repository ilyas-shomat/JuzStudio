//
//  StudioMainProtocols.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 22.02.2023.
//

import Foundation

protocol StudioMainViewControllerDelegate {
    var viewModel: StudioMainViewModelDelegate? { get set }
}

protocol StudioMainViewModelDelegate {
    var viewController: StudioMainViewControllerDelegate? { get set }
    
    func onPlayPause()
}
