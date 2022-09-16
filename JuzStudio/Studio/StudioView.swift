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

struct StudioView: View {
    @ObservedObject private var viewController: StudioViewController
        
    init(_ viewController: StudioViewController) {
        self.viewController = viewController
    }
    
    var body: some View {
        VStack {
            headerView
            contentView
            Spacer()
            bottomView
        }
        .background(Color.appdarkBackground
        )
        .ignoresSafeArea()
    }
    
    private var headerView: some View {
        HStack {
            Image("backButton")
                .padding(.bottom, 30)
            
            Spacer()
            VStack {
                Text("Recording")
                    .foregroundColor(.white)
                    .bold()
                HStack {
                    Spacer()
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(.red)
                    Text("00:00:00")
                        .foregroundColor(.white)
                        .font(Font.system(size: 15))
                    Spacer()
                }
            }
            Spacer()
            
            Text("Next")
                .foregroundColor(.appPurple)
                .padding(.bottom, 30)

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
                                    waveTapped: viewController.stopTimer
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
            bottomOption: $viewController.selectedBottomOption,
            mixerButtonTapped: viewController.mixerTapped,
            recordButtonTapped: viewController.recordTapped,
            playButtonTapped: viewController.playTapped,
            restartButtonTapped: viewController.restartTapped
        )
    }
}

struct StudioMainView_Previews: PreviewProvider {
    static var previews: some View {
        StudioView(StudioViewController())
    }
}

