//
//  StudioMainView.swift
//  JuzAudioWave
//
//  Created by Ilyas Shomat on 23.08.2022.
//

import Foundation
import SwiftUI
import UIKit
import Combine

struct StudioMainView: View {
    @ObservedObject private var viewController: StudioMainViewController
            
    init(_ viewController: StudioMainViewController) {
        self.viewController = viewController
    }
    
    var body: some View {
        ZStack {
            VStack {
                headerView

                if viewController.selectedBottomOption == .lyrics {
                    LyricsView()
                }
                else {
                    contentView
                }
                
                Spacer()
                bottomView
            }
            
            if viewController.isEffectsSlidingOptionOpened {
                VStack {
                    Spacer()
                    EffectsPopUpView(
                        type: $viewController.currentEffectType,
                        typeDict: $viewController.typeDict,
                        swipedToPop: viewController.swipedDownEffectsPopUp,
                        playButtonTapped: viewController.playPauseTapped,
                        restartButtonTapped: viewController.restartTapped,
                        effectsButtonTap: viewController.swipedDownEffectsPopUp
                    )
                }
                .transition(.move(edge: .bottom))
            }
        }
        .background(Color.appdarkBackground)
        .ignoresSafeArea()
    }
    
    private var headerView: some View {
        HStack {
//            Image("backButtonviewController")
//                .padding(.bottom, 30)
            
            Spacer()
            VStack {
                Text(viewController.selectedBottomOption == .lyrics ? "Lyrics" : "Recording")
                    .foregroundColor(.white)
                    .bold()
                
                HStack {
                    Spacer()
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(viewController.selectedBottomOption == .lyrics ? .clear : .red)
                    Text(viewController.selectedBottomOption == .lyrics ? "" : "00:00:00")
                        .foregroundColor(.white)
                        .font(Font.system(size: 15))
                    Spacer()
                }
            }
            Spacer()
            
//            Text("Next")
//                .foregroundColor(.appPurple)
//                .padding(.bottom, 30)

        }
        .padding(.horizontal, 20)
        .padding(.top, 10.withSafeAreaInset(.top))
    }
    
    private var contentView: some View {
        HStack {
            audioTypesView
            bitsView
        }
    }
    
    private var audioTypesView: some View {
        VStack(spacing: 0) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 48, height: 24)
                        
            ForEach(0..<viewController.mixerCellEntities.count, id: \.self) { index in
                let isEmptyMixerType = viewController.mixerCellEntities[index].type == .empty
                
                MixerCell(
                    entity: viewController.mixerCellEntities[index],
                    backgroundColor: isEmptyMixerType ? .appWhiteWithOpacity : viewController.mixerCellColors[index],
                    mixerFoldedState: viewController.mixerFoldedState,
                    tapAddNewVoice: viewController.addNewMixerVoice
                )
                
                if index < viewController.mixerCellEntities.count - 1 {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 48, height: 10)
                }
            }
            
            Spacer()
        }
    }
    
    private var bitsView: some View {
        VStack(spacing: 0) {
            ScrollViewReader { reader in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        RulerView(
                            incrementor:  $viewController.incrementor,
                            bits: viewController.bits,
                            reader: reader
                        )
                        Spacer()
                    }
                    
                    ForEach(0..<viewController.mixerCellEntities.count, id: \.self) { index in
                        HStack(spacing: 0) {
                            if viewController.mixerCellEntities[index].type != .empty {
                                AudioWaveView(
                                    incrementor: $viewController.incrementor,
                                    bits: viewController.bits,
                                    waveColor: viewController.mixerCellColors[index],
                                    reader: reader,
                                    waveTapped: {}
                                )
                            }
                            
                            else {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 48, height: 84)
                            }
                            Spacer()
                        }
                    }
                }
                .simultaneousGesture(
                    DragGesture()
                        .onChanged { gesture in
                            viewController.stopTimer()
                        }
                )
            }
            Spacer()
        }
    }
    
    private var bottomView: some View {
        StudioBottomView(
            isMagicSelected: $viewController.isMagicSelected,
            isPlaying: $viewController.isPlaying,
            bottomOption: $viewController.selectedBottomOption,
            effectCellEntities: viewController.effectsCellEntities,
            mixerButtonTapped: viewController.mixerTapped,
            recordButtonTapped: viewController.recordTapped,
            playButtonTapped: viewController.playPauseTapped,
            restartButtonTapped: viewController.restartTapped,
            effectsButtonTap: viewController.effectTypeSelected
        )
    }
}

struct StudioMainView_Previews: PreviewProvider {
    static var previews: some View {
        StudioMainView(StudioMainViewController())
    }
}

