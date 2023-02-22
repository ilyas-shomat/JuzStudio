//
//  StudioMainViewModel.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 22.02.2023.
//

import Foundation

final class StudioMainViewModel: StudioMainViewModelDelegate {
    var viewController: StudioMainViewControllerDelegate?
    var superpoweredService: SuperpoweredService!
    
    init() {
        print("/// StudioMainViewModel")
        
        superpoweredService = SuperpoweredService()
        
//        superPowered.tempFunc()
        superpoweredService.tempFunc()
    }
}

// JuzStudio-Bridging-Header
