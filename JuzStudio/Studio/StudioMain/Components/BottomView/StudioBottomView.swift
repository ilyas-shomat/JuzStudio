//
//  StudioBottomView.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 31.08.2022.
//

import Foundation
import SwiftUI

enum StudioBottomViewSelectedOption {
    case effects
    case studio
    case lyrics
}

struct StudioBottomView: View {
    @Binding private var isMagicSelected: Bool
    @Binding private var bottomOption: StudioBottomViewSelectedOption
    
    private var effectCellEntities: [EffectCellEntity]
    
    private var mixerButtonTapped: () -> Void
    private var recordButtonTapped: () -> Void
    private var playButtonTapped: () -> Void
    private var restartButtonTapped: () -> Void
    private var effectsButtonTap: (EffectsPopUpType) -> Void
    
    init(
        isMagicSelected: Binding<Bool>,
        bottomOption: Binding<StudioBottomViewSelectedOption>,
        effectCellEntities: [EffectCellEntity],
        mixerButtonTapped: @escaping () -> Void,
        recordButtonTapped: @escaping () -> Void,
        playButtonTapped: @escaping () -> Void,
        restartButtonTapped: @escaping () -> Void,
        effectsButtonTap: @escaping (EffectsPopUpType) -> Void
    ) {
        _isMagicSelected = isMagicSelected
        _bottomOption = bottomOption
        
        self.effectCellEntities = effectCellEntities
        self.mixerButtonTapped = mixerButtonTapped
        self.recordButtonTapped = recordButtonTapped
        self.playButtonTapped = playButtonTapped
        self.restartButtonTapped = restartButtonTapped
        self.effectsButtonTap = effectsButtonTap
    }
    
    var body: some View {
        mainStudioButtons
    }
    
    private var mainStudioButtons: some View {
        VStack {
            Spacer()
            
            if bottomOption == .effects {
                EffectsView(
                    entities: effectCellEntities,
                    effectsButtonTap: effectsButtonTap
                )
                .transition(.move(edge: .leading))
            }
            
            allStudioButtons
        }
    }
    
    private var allStudioButtons: some View {
        VStack(alignment: .center, spacing: 15) {
            studioTopButtons
            studioBottomButtons
        }
        .padding(.horizontal)
        .padding()
    }
    
    private var studioTopButtons: some View {
        HStack(spacing: 20) {
            mixerButton
            Spacer()
            restartButton
            recordButton
            playButton
            Spacer()
            magicButton
        }
    }
    
    private var studioBottomButtons: some View {
        HStack(spacing: 25) {
            effectsButton
            studioButton
            lyricsButton
        }
        .offset(x: -10)
    }
    
    private var mixerButton: some View {
        Button(action: mixerButtonTapped) {
            VStack {
                Image("mixer")
                Text("Mixer")
                    .font(.system(size: 13))
                    .foregroundColor(.white)
            }
        }
    }
    
    private var restartButton: some View {
        Button(action: restartButtonTapped) {
            Image("restart")
        }
    }
    
    private var recordButton: some View {
        Button(action: recordButtonTapped) {
            Image("record")
        }
    }
    
    private var playButton: some View {
        Button(action: playButtonTapped) {
            Image("play")
        }
    }
    
    private var magicButton: some View {
        Button {
            isMagicSelected.toggle()
        } label: {
            VStack {
                Image(isMagicSelected ? "magicSelected" : "magic")
                Text("Magic")
                    .font(.system(size: 13))
                    .foregroundColor(.white)
            }
        }
    }
    
    private var effectsButton: some View {
        Button(
            action: {
                withAnimation() {
                    bottomOption = .effects
                }
            },
            label: {
                Text("Effects")
                    .foregroundColor(bottomOption == .effects ? .appPurple : .white)
            }
        )
    }
    
    private var studioButton: some View {
        Button(
            action: {
                withAnimation() {
                    bottomOption = .studio
                }
            },
            label: {
                Text("Studio")
                    .foregroundColor(bottomOption == .studio ? .appPurple : .white)
            }
        )
    }
    
    private var lyricsButton: some View {
        Button(
            action: {
                withAnimation() {
                    bottomOption = .lyrics
                }
            },
            label: {
                Text("Lyrics")
                    .foregroundColor(bottomOption == .lyrics ? .appPurple : .white)
            }
        )
    }
}
