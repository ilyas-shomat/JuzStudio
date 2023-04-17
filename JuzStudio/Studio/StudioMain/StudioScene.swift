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

final class StudioScene: UIViewController, ObservableObject {
    var manager: StudioManagerDelegate?
    
    @Published var mainAudioAmplitudes: [CGFloat] = .init()
    var cancellable: Cancellable?
    
    let mixerCellColors: [Color] = [.appPurple, .appLightBlue, .appLightGreen]
    
    @Published var mixerCellEntities: [MixerCellEntity] = [
        .init(type: .music, desc1: "Beat’s Name", desc2: "Beat’s Key"),
//        .init(type:  .voice, desc1: "Голос"),
//        .init(type: .voice, desc1: "Голос"),
        .init(type: .empty, desc1: "Добавить дорожку"),
    ]
    
    var effectsCellEntities: [EffectCellEntity] = [
        .init(effectType: .delay, name: "Delay", image: "delay", isSelected: true),
        .init(effectType: .reverb, name: "Reverb", image: "reverb", isSelected: true),
        .init(effectType: .eq, name: "EQ", image: "eq", isSelected: true),
        .init(effectType: .compressor, name: "Compressor", image: "compressor", isSelected: true),
    ]
    
    @Published var incrementor: Int = 0
    @Published var isMagicSelected: Bool = false
    @Published var mixerFoldedState: MixerUnfoldedState = .low
    @Published var selectedBottomOption: StudioBottomViewSelectedOption = .effects
    @Published var isEffectsSlidingOptionOpened: Bool = false
    @Published var currentEffectType: EffectsPopUpType = .delay
    
    @Published var isPlaying: Bool = false {
        didSet {
//            stopTimer()
        }
    }
    
    @Published var typeDict: [EffectsPopUpType: [EffectsPopUpCellEntity]] = [
        .delay: [
            .init(name: "Dry level", value: 0, minVal: 0, maxVal: 1),
            .init(name: "Wet", value: 0, minVal: 0, maxVal: 1),
            .init(name: "BPM", value: 40, minVal: 40, maxVal: 250),
            .init(name: "Beats", value: 0.03, minVal: 0.03, maxVal: 2),
            .init(name: "Decay", value: 0, minVal: 0, maxVal: 0.99)
        ],
        .reverb: [
            .init(name: "Dry level", value: 0, minVal: 0, maxVal: 1),
            .init(name: "Wet", value: 0, minVal: 0, maxVal: 1),
            .init(name: "Mix", value: 0, minVal: 0, maxVal: 1),
            .init(name: "Damp", value: 0, minVal: 0, maxVal: 1),
            .init(name: "Room size", value: 0, minVal: 0, maxVal: 1),
            .init(name: "Pre-delay", value: 0, minVal: 0, maxVal: 500),
            .init(name: "Low cut", value: -12, minVal: -12, maxVal: 0)
        ],
        .eq: [
            .init(name: "Low", value: 0, minVal: 0, maxVal: 8),
            .init(name: "Mid", value: 0, minVal: 0, maxVal: 8),
            .init(name: "High", value: 0, minVal: 0, maxVal: 8)
        ],
        .compressor: [
            .init(name: "Input", value: -24, minVal: -24, maxVal: 24),
            .init(name: "Output", value: -24, minVal: -24, maxVal: 24),
            .init(name: "Wet", value: -24, minVal: -24, maxVal: 24),
            .init(name: "Attack", value: 0.1, minVal: 0.1, maxVal: 1000),
            .init(name: "Release", value: 100, minVal: 100, maxVal: 4000),
            .init(name: "Ratio", value: 1, minVal: 1, maxVal: 6),
            .init(name: "Treshold", value: -40, minVal: -40, maxVal: 0),
            .init(name: "Highpass", value: 1, minVal: 1, maxVal: 10000)
        ]
    ]

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

        view.backgroundColor = .appdarkBackground
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
        
        cancellable = Timer.publish(every: 0.02, on: .main, in: .common)
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
    
    func mixerTapped() {
        withAnimation {
            if mixerFoldedState == .low {
                mixerFoldedState = .full
            }
            else {
                mixerFoldedState = .low
            }
        }
    }
    
    func recordTapped() {

    }
    
    func playPauseTapped() {
        isPlaying.toggle()
        manager?.onPlayPause()
        startTimer()
    }
    
    func restartTapped() {
        
    }
    
    func bottomOptionSelected(option: StudioBottomViewSelectedOption) {
        selectedBottomOption = option
    }
    
    func effectTypeSelected(type: EffectsPopUpType) {
        currentEffectType = type
        
        withAnimation(.linear) {
            isEffectsSlidingOptionOpened = true
        }
    }
    
    func swipedDownEffectsPopUp() {
        withAnimation {
            isEffectsSlidingOptionOpened = false
        }
    }
    
    func swipedDownEffectsPopUp(type: EffectsPopUpType) {
        withAnimation {
            isEffectsSlidingOptionOpened = false

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.effectTypeSelected(type: type)
            }
        }
    }
}

extension StudioScene: StudioSceneDelegate {
    func setAmplitudesList(_ amplitudesList: [[CGFloat]]) {
        
    }
    
    func setFirstAmplitudes(_ amplitudes: [Float]) {
        mainAudioAmplitudes = amplitudes.map { CGFloat($0) }
    }
    
    func mainAudioPlayingFinished() {
        DispatchQueue.main.async { [weak self] in
            self?.isPlaying = false
            self?.stopTimer()
        }
    }
}

extension StudioScene {
    class func getInstance() -> StudioScene {
        let scene = StudioScene()
        
        let superpoweredService = SuperpoweredService(key: AppConstants.superpoweredKey)
        let audioManager = AudioManager()
        
        if let superpoweredService = superpoweredService {
            let manager = StudioManager(
                audioFileUrl: heroicAudioPath,
                superpoweredService: superpoweredService,
                audioManager: audioManager
            )
            scene.manager = manager
            manager.scene = scene
        }
        else {
            assertionFailure("ERROR, SuperpoweredService not initialized")
        }
        
        return scene
    }
}

