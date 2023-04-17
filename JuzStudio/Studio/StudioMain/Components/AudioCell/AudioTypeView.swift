//
//  AudioTypeView.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 17.04.2023.
//

import SwiftUI

struct AudioTypeView: View {
    @Binding private var unfoldingLevel: AudioCellsUnfoldingLevel
    @Binding private var sliderVal: Double
    
    private let imageName: String
    private let backgroundColor: Color
    private let beatsName: String
    private let beatsKey: String
    
    init(
        unfoldingLevel: Binding<AudioCellsUnfoldingLevel>,
        sliderVal: Binding<Double>,
        imageName: String,
        backgroundColor: Color,
        beatsName: String,
        beatsKey: String
    ) {
        _unfoldingLevel = unfoldingLevel
        _sliderVal = sliderVal
        self.imageName = imageName
        self.backgroundColor = backgroundColor
        self.beatsName = beatsName
        self.beatsKey = beatsKey
    }
    
    var body: some View {
        HStack {
            setMixerView()
        }
    }
    
    private func setMixerView() -> some View {
        VStack {
            switch unfoldingLevel {
            case .zero: setFoldedMixerView()
            case .half: setHalfUnfoldedMixerView()
            case .fully: setFullyUnfoldedMixerView()
            }
        }
    }
    
    private func setFoldedMixerView() -> some View {
        Image(imageName)
            .frame(width: 48, height: 84)
            .background(backgroundColor)
            .cornerRadius(15, corners: [.topRight, .bottomRight])
    }
    
    private func setHalfUnfoldedMixerView() -> some View {
        HStack(spacing: 20) {
            setFoldedMixerView()
            
            VStack {
                Text(beatsName)
                    .lineLimit(2)
                    .foregroundColor(.white)

                Text(beatsKey)
                    .foregroundColor(.appDarkPurple)
            }
            .multilineTextAlignment(.center)
        }
        .padding(.trailing, 10)
    }
    
    private func setFullyUnfoldedMixerView() -> some View {
        VStack {
            HStack {
                Text(beatsName)
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
    }
}

// MARK: Previews
struct AudioPromtView_Previews1: PreviewProvider {
    static var previews: some View {
        AudioTypeView(
            unfoldingLevel: .constant(.zero),
            sliderVal: .constant(0),
            imageName: "noteIcon",
            backgroundColor: .appPurple,
            beatsName: "Beat’s Name",
            beatsKey: "Beat’s Key"
        )
        .background(Color.black)
        .previewLayout(.sizeThatFits)
    }
}

struct AudioPromtView_Previews2: PreviewProvider {
    static var previews: some View {
        AudioTypeView(
            unfoldingLevel: .constant(.half),
            sliderVal: .constant(0),
            imageName: "noteIcon",
            backgroundColor: .appPurple,
            beatsName: "Beat’s Name",
            beatsKey: "Beat’s Key"
        )
        .background(Color.black)
        .previewLayout(.sizeThatFits)
    }
}

struct AudioPromtView_Previews3: PreviewProvider {
    static var previews: some View {
        AudioTypeView(
            unfoldingLevel: .constant(.fully),
            sliderVal: .constant(0),
            imageName: "noteIcon",
            backgroundColor: .appPurple,
            beatsName: "Beat’s Name",
            beatsKey: "Beat’s Key"
        )
        .background(Color.black)
        .previewLayout(.sizeThatFits)
    }
}
