//
//  EffectsPopUpView.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 19.09.2022.
//

import SwiftUI

struct EffectsPopUpView: View {
    @Binding private var type: EffectsPopUpType
    @Binding private var typeDict: [EffectsPopUpType: [EffectsPopUpCellEntity]]
    
    private var swipedToPop: () -> Void
    private var playButtonTapped: () -> Void
    private var restartButtonTapped: () -> Void
    private var effectsButtonTap: (EffectsPopUpType) -> Void
    
    init(
        type: Binding<EffectsPopUpType>,
        typeDict: Binding<[EffectsPopUpType: [EffectsPopUpCellEntity]]>,
        swipedToPop: @escaping () -> Void,
        playButtonTapped: @escaping () -> Void,
        restartButtonTapped: @escaping () -> Void,
        effectsButtonTap: @escaping (EffectsPopUpType) -> Void
    ) {
        _type = type
        _typeDict = typeDict
        
        self.swipedToPop = swipedToPop
        self.playButtonTapped = playButtonTapped
        self.restartButtonTapped = restartButtonTapped
        self.effectsButtonTap = effectsButtonTap
    }
    
    var body: some View {
        content
    }
    
    private var content: some View {
        VStack {
            popContent
            slidersContent
            buttonsContent
            effectsContent
        }
        .background(Color.appdarkBackground)
    }
    
    private var popContent: some View {
        VStack(spacing: 12) {
            HStack {
                Spacer()
                Rectangle()
                    .frame(width: 42, height: 5)
                    .foregroundColor(.appDarkPurple)
                    .cornerRadius(5, corners: .allCorners)
                    .padding(.top, 12)
                Spacer()
            }
            
            Text("POP")
                .foregroundColor(.white)
        }
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onEnded { value in
                    if value.translation.height > 0 {
                        swipedToPop()
                    }
                }
        )
    }
    
    private var slidersContent: some View {
        VStack(spacing: 12) {
            ForEach(0..<(typeDict[type]?.count ?? .init()), id: \.self) { index in
                EffectsPopUpCell(
                    type: $type,
                    typeDict: $typeDict,
                    index: index
                )
            }
        }
        .padding(.horizontal, 25)
        .padding(.vertical, 12)
    }
    
    private var buttonsContent: some View {
        HStack(spacing: 0) {
            restartButton
            Spacer()
            playButton
            Spacer()
            rerunButton
        }
        .padding(.horizontal, 50)
        .padding(.vertical, 12)

    }
    
    private var effectsContent: some View {
        HStack(spacing: 0) {
            ForEach(0..<EffectsPopUpType.allCases.count, id: \.self) { index in
                Text(EffectsPopUpType.allCases[index].rawValue)
                    .foregroundColor(.appDarkPurple)
                    .onTapGesture {
                        effectsButtonTap(EffectsPopUpType.allCases[index])
                    }
                
                if index < EffectsPopUpType.allCases.count - 1 {
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 35)
        .padding(.bottom, 40)
    }
    
    private var restartButton: some View {
        Button(action: restartButtonTapped) {
            Image("restart")
        }
    }
    
    private var playButton: some View {
        Button(action: playButtonTapped) {
            Image("play")
        }
    }
    
    private var rerunButton: some View {
        Button(action: {}) {
            Image("rerun")
        }
    }
}
