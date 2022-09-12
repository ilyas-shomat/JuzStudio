//
//  StudioMainView.swift
//  JuzAudioWave
//
//  Created by Ilyas Shomat on 23.08.2022.
//

import Foundation
import SwiftUI
import Combine

struct StudioView: View {
    @ObservedObject private var viewController: StudioViewController
        
    init(_ viewController: StudioViewController) {
        self.viewController = viewController
    }
    
    var body: some View {
        VStack {
            headerView
            rulerView
            contentView
            Spacer()
            
            Button("continue") {
                viewController.startTimer()
            }
            
            Button("add new bits") {
                
            }
            
            Button("tap mixer unfold") {
                withAnimation(.linear(duration: 0.5)) {
                    if viewController.mixerFoldedState == .medium {
                        viewController.mixerFoldedState = .full
                    }
                    else {
                        viewController.mixerFoldedState = .medium
                    }
                }
            }
        }
        .background(.black)
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
    
    private var rulerView: some View {
        var leadingPadding: CGFloat = 187
        
        if viewController.mixerFoldedState == .full {
            leadingPadding = 280
        }
        
        return RulerView().padding(.leading, leadingPadding + 5)
    }
    
    private var contentView: some View {
        VStack(spacing: 5) {
            HStack {
                MixerCell(
                    entity: viewController.mixerCellEntities[0],
                    backgroundColor: viewController.mixerCellColors[0],
                    mixerFoldedState: viewController.mixerFoldedState,
                    tapAddNewVoice: viewController.addNewMixerVoice
                )
            
                AudioWaveView(
                    incrementor: $viewController.incrementor,
                    bits: viewController.bits,
                    waveColor: viewController.mixerCellColors[0],
                    setLastIndex: viewController.stopTimer
                )
            }

        
            ForEach(1..<viewController.mixerCellEntities.count, id: \.self) { index in
                HStack {
                    let isEmptyMixerType = viewController.mixerCellEntities[index].type == .empty
                    
                    MixerCell(
                        entity: viewController.mixerCellEntities[index],
                        backgroundColor: isEmptyMixerType ? .appWhiteWithOpacity : viewController.mixerCellColors[index],
                        mixerFoldedState: viewController.mixerFoldedState,
                        tapAddNewVoice: viewController.addNewMixerVoice
                    )
                
                    if viewController.mixerCellEntities[index].type != .empty {
                        AudioWaveView(
                            incrementor: $viewController.incrementor,
                            bits: viewController.bits,
                            waveColor: viewController.mixerCellColors[index],
                            setLastIndex: viewController.stopTimer
                        )
                    }
                    
                    Spacer()
            }
            }
        }
    }
}

struct StudioMainView_Previews: PreviewProvider {
    static var previews: some View {
        StudioView(StudioViewController())
    }
}

