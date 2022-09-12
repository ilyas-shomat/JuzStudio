//
//  MixerCell.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 31.08.2022.
//

import Foundation
import SwiftUI

enum MixerUnfoldedState {
    case low
    case medium
    case full
}

struct MixerCell: View {
    @State private var sliderVal: Double = 0
    
    private var entity: MixerCellEntity
    private var backgroundColor: Color
    private var mixerFoldedState: MixerUnfoldedState
    private let tapAddNewVoice: (() -> Void)?
    
    private var imageName: String {
        switch entity.type {
        case .music:
            return "noteIcon"
        case .voice:
            return "activeMicrophoneIcon"
        case .empty:
            return "addableMicrophoneIcon"
        }
    }
    
    init(
        entity: MixerCellEntity,
        backgroundColor: Color,
        mixerFoldedState: MixerUnfoldedState = .medium,
        tapAddNewVoice: (() -> Void)? = nil
    ) {
        self.entity = entity
        self.backgroundColor = backgroundColor
        self.mixerFoldedState = mixerFoldedState
        self.tapAddNewVoice = tapAddNewVoice
    }
    
    var body: some View {
        HStack {
            switch mixerFoldedState {
            case .low:
                lowUnfoldedStateView
            case .medium:
                meduimUnfoldedStateView
            case .full:
                fullUnfoldedStateView
            }
        }
        .background(.clear)
        .onTapGesture {
            if entity.type == .empty {
                tapAddNewVoice?()
            }
        }
    }
    
    private var lowUnfoldedStateView: some View {
        HStack {
            button
        }
    }
    
    private var meduimUnfoldedStateView: some View {
        HStack {
            button
            Spacer()
            description
            Spacer()
        }
        .frame(width: 187)
    }
    
    private var fullUnfoldedStateView: some View {
        if entity.type == .empty {
            return AnyView(
                HStack {
                    button
                    Spacer()
                    description
                    Spacer()
                }
                .frame(width: 280, height: 84)
            )
        }
        else {
            return AnyView(
                VStack {
                    HStack {
                        Text("Beat")
                        Spacer()
                        Text("\(Int(100 * sliderVal))%")
                    }
                    .padding(.trailing, 20)
                    .foregroundColor(.white)
                
                    HStack {
                        AppSlider(
                            thumbColor: .white,
                            minTrackColor: .white,
                            maxTrackColor: .white.withAlphaComponent(0.5),
                            value: $sliderVal
                        )
                    }
                }
                .padding(.horizontal, 20)
                .frame(width: 280, height: 84)
                .background(backgroundColor)
                .cornerRadius(15, corners: [.topRight, .bottomRight])
            )
        }
    }
    
    private var button: some View {
        Image(imageName)
            .frame(width: 48, height: 84)
            .background(backgroundColor)
            .cornerRadius(15, corners: [.topRight, .bottomRight])
    }
    
    private var description: some View {
        VStack {
            if let desc1Text = entity.desc1 {
                Text(desc1Text)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .foregroundColor(.white)
            }
            
            if let desc2Text = entity.desc2 {
                Text(desc2Text)
                    .foregroundColor(.appDarkPurple)
            }
        }
    }
}


struct MixerCell_Previews: PreviewProvider {
    static var previews: some View {
        MixerCell(
            entity: .init(type: .music, desc1: "Beat’s Name", desc2: "Beat’s Key"),
            backgroundColor: .appLightBlue
        )
            .previewLayout(.sizeThatFits)
            .background(.black)
    }
}

struct MixerCell_Previews_Low_Unfolded: PreviewProvider {
    static var previews: some View {
        MixerCell(
            entity: .init(type: .music, desc1: "Beat’s Name", desc2: "Beat’s Key"),
            backgroundColor: .appLightGreen,
            mixerFoldedState: .low
            
        )
        .previewLayout(.sizeThatFits)
        .background(.black)
    }
}

struct MixerCell_Previews_Active_Voice: PreviewProvider {
    static var previews: some View {
        MixerCell(
            entity: .init(type: .voice, desc1: "Голос"),
            backgroundColor: .appLightBlue
        )
            .previewLayout(.sizeThatFits)
            .background(.black)
    }
}

struct MixerCell_Previews_Empty_State: PreviewProvider {
    static var previews: some View {
        MixerCell(
            entity: .init(type: .empty, desc1: "Добавить дорожку"),
            backgroundColor: .appWhiteWithOpacity,
            mixerFoldedState: .full
        )
        .previewLayout(.sizeThatFits)
        .background(.black)
    }
}

struct MixerCell_Previews_Empty_Medium_State: PreviewProvider {
    static var previews: some View {
        MixerCell(
            entity: .init(type: .empty, desc1: "Добавить дорожку"),
            backgroundColor: .appWhiteWithOpacity,
            mixerFoldedState: .medium
        )
        .previewLayout(.sizeThatFits)
        .background(.black)
    }
}

struct MixerCell_Previews_Unfolded: PreviewProvider {
    static var previews: some View {
        MixerCell(
            entity: .init(type: .music, desc1: "Beat’s Name", desc2: "Beat’s Key"),
            backgroundColor: .appPurple,
            mixerFoldedState: .full
        )
        .previewLayout(.sizeThatFits)
        .background(.black)
    }
}





