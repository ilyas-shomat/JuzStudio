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
    
    private var mixerButtonTapped: () -> Void
    private var recordButtonTapped: () -> Void
    private var playButtonTapped: () -> Void
    private var restartButtonTapped: () -> Void
    
    init(
        isMagicSelected: Binding<Bool>,
        bottomOption: Binding<StudioBottomViewSelectedOption>,
        mixerButtonTapped: @escaping () -> Void,
        recordButtonTapped: @escaping () -> Void,
        playButtonTapped: @escaping () -> Void,
        restartButtonTapped: @escaping () -> Void
    ) {
        _isMagicSelected = isMagicSelected
        _bottomOption = bottomOption
        
        self.mixerButtonTapped = mixerButtonTapped
        self.recordButtonTapped = recordButtonTapped
        self.playButtonTapped = playButtonTapped
        self.restartButtonTapped = restartButtonTapped
    }
    
    var body: some View {
        mainStudioButtons
    }
    
    private var mainStudioButtons: some View {
        ZStack {
            allStudioButtons
            
//            if showingBottomSheet {
//                BottomSheet(showOverlay: $showingBottomSheet)
//            }
        }
    }
    
    private var allStudioButtons: some View {
        VStack(alignment: .center, spacing: 15) {
            Spacer()
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
//        .background(.black)
    }
    
    private var studioBottomButtons: some View {
        HStack(spacing: 25) {
            effectsButton
            studioButton
            lyricsButton
        }
        .offset(x: -10)
//        .background(.black)
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
//        Button {
//            bottomOptionSelected(.effects)
//            withAnimation {
//                self.showingBottomSheet.toggle()
//            }
//        } label: {
//            Text("Effects")
//                .foregroundColor(bottomOptions == .effects ? .gray : .white)
//        }
        
        Button(
            action: {
                bottomOption = .effects
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
                bottomOption = .studio
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
                bottomOption = .lyrics
            },
            label: {
                Text("Lyrics")
                    .foregroundColor(bottomOption == .lyrics ? .appPurple : .white)
            }
        )
    }
}


//struct StudioBottomView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudioBottomView()
//    }
//}
