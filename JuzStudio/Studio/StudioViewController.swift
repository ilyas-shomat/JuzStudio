//
//  StudioViewController.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 31.08.2022.
//

import Foundation
import UIKit
import SwiftUI
import Combine

final class StudioViewController: UIViewController, ObservableObject {
    var bits: [CGFloat] = testBits2
    var cancellable: Cancellable?
    
    let mixerCellColors: [Color] = [.appPurple, .appLightBlue, .appLightGreen]
    
    @Published var mixerCellEntities: [MixerCellEntity] = [
        .init(type: .music, desc1: "Beat’s Name", desc2: "Beat’s Key"),
//        .init(type: .voice, desc1: "Голос"),
        .init(type: .voice, desc1: "Голос"),
        .init(type: .empty, desc1: "Добавить дорожку"),
    ]
    
    @Published var mixerFoldedState: MixerUnfoldedState = .medium
    @Published var incrementor: Int = 0

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func setupView() {
        let controller = UIHostingController(rootView: StudioView(self))
        controller.view.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = .black
        view.addSubview(controller.view)
        
        controller.didMove(toParent: self)
        
        let allConstraints: [NSLayoutConstraint] = [
            controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            controller.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            controller.view.topAnchor.constraint(equalTo: view.topAnchor)
        ]

        NSLayoutConstraint.activate(allConstraints)
    }
    
    func startTimer() {
        incrementor = 0
        
        cancellable = Timer.publish(every: 0.04, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.incrementor += 1
            }
    }
    
    func stopTimer() {
        cancellable?.cancel()
    }
    
    func addNewMixerVoice() {
        if mixerCellEntities.count < 4 {
            _ = mixerCellEntities.popLast()
            
            mixerCellEntities.append(.init(type: .voice, desc1: "Голос"))
            mixerCellEntities.append(.init(type: .empty, desc1: "Добавить дорожку"))
        }
    }
}



var testBits1: [CGFloat] = [
    0.8, 0.9, 1, 0.45, 0.7, 0.1, 0.3, 0.5, 0.5, 0.3, 0.8, 0.9, 1, 0.45, 0.7, 0.3, 0.5, 0.5, 0.3, 0.8, 0.9, 0.3, 0.8,
    0.9, 1, 0.45, 0.7, 0.3, 0.8, 0.9, 0.3, 0.8, 0.9, 1, 0.45, 0.7, 0.3, 0.7, 0.1, 0.3, 0.5, 0.5, 0.3, 0.8, 0.9, 1,
    0.45, 0.7, 0.3, 0.5, 0.5, 0.3, 0.8, 0.9, 0.3, 0.3, 0.5, 0.5, 0.3, 0.8, 0.9, 1, 0.45, 0.7, 0.3, 0.5, 0.5, 0.3, 0.8,
    0.9, 0.3, 0.8, 0.9, 1, 0.45, 0.7, 0.3, 0.8, 0.9, 0.3, 0.8, 0.9, 1, 0.45, 0.7, 0.3, 0.7, 0.1, 0.3, 0.5, 0.5, 0.3,
    0.8, 0.9, 1, 0.45, 0.7, 0.3, 0.5, 0.5, 0.3, 0.8, 0.9, 0.3, 0.3, 0.5, 0.5, 0.3, 0.8, 0.9, 1, 0.45, 0.7, 0.3, 0.5,
    0.5, 0.3, 0.8, 0.9, 0.3, 0.8, 0.9, 1, 0.45, 0.7, 0.3, 0.8, 0.9, 0.3, 0.8, 0.9, 1, 0.45, 0.7, 0.3, 0.7, 0.1, 0.3,
    0.5, 0.5, 0.3, 0.8, 0.9, 1, 0.45, 0.7, 0.3, 0.5, 0.5, 0.3, 0.8,0.9, 0.3, 0.8, 0.9, 1, 0.45, 0.7, 0.3, 0.7, 0.1,
    0.3, 0.5, 0.5, 0.3, 0.8, 0.9, 1, 0.45, 0.7, 0.3, 0.5, 0.5, 0.3, 0.8, 0.9, 0.3, 0.3, 0.5, 0.5, 0.3, 0.8, 0.9, 1,
    0.45, 0.7, 0.3, 0.5, 0.5, 0.3, 0.8, 0.9, 0.3, 0.8, 0.9, 1, 0.45, 0.7, 0.3, 0.8, 0.9, 0.3, 0.8, 0.9, 1, 0.45, 0.7,
    0.3, 0.7, 0.1, 0.3, 0.5, 0.5, 0.3, 0.8, 0.9, 1, 0.45, 0.7, 0.3, 0.5, 0.5, 0.3
]

var testBits2: [CGFloat] = [
    0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1,
    0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1,
    
    0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2,
    0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2,
    
    0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3,
    0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3,

    0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4,
    0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4,
    
    0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5,
    0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5,

    0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6,
    0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6,

    0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7,
    0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7,

    0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8,
    0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8,

    0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9,
    0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9,
]
