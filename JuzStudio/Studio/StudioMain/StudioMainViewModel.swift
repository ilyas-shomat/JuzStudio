//
//  StudioMainViewModel.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 22.02.2023.
//

import Foundation

final class StudioMainViewModel: StudioMainViewModelDelegate {
    var viewController: StudioMainViewControllerDelegate?
    private let superpoweredService: SuperpoweredService
    
    init(superpoweredService: SuperpoweredService) {
        self.superpoweredService = superpoweredService
        
        superpoweredService.setupMainPlayer()
    }
    
    func onPlayPause() {
        superpoweredService.onPlayPause()
    }
}
