//
//  AudioCell.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 07.04.2023.
//

import SwiftUI

enum AudioCellsUnfoldingLevel {
    case zero
    case half
    case fully
}

struct AudioCell: View {
    @Binding private var unfoldingLevel: AudioCellsUnfoldingLevel
    @Binding private var sliderVal: Double
    
    private let amplitudes: [CGFloat]
    private let waveformColor: Color
    private let imageName: String
    private let beatsName: String
    private let beatsKey: String
    
    init(
        unfoldingLevel: Binding<AudioCellsUnfoldingLevel>,
        sliderVal: Binding<Double>,
        amplitudes: [CGFloat],
        waveformColor: Color,
        imageName: String,
        beatsName: String,
        beatsKey: String
    ) {
        self._unfoldingLevel = unfoldingLevel
        self._sliderVal = sliderVal
        self.amplitudes = amplitudes
        self.waveformColor = waveformColor
        self.imageName = imageName
        self.beatsName = beatsName
        self.beatsKey = beatsKey
    }
    
    var body: some View {
        HStack {
            audioTypeView
            audioWaveformView
        }
    }
    
    private var audioTypeView: AudioTypeView {
        .init(
            unfoldingLevel: $unfoldingLevel,
            sliderVal: $sliderVal,
            imageName: imageName,
            backgroundColor: waveformColor,
            beatsName: beatsName,
            beatsKey: beatsKey
        )
    }
    
    private var audioWaveformView: AudioWaveformView {
        .init(amplitudes: amplitudes, waveColor: waveformColor)
    }
}

//MARK: - Previews
struct AudioCell_Prewiew1: PreviewProvider {
    static var previews: some View {
        AudioCell(
            unfoldingLevel: .constant(.zero),
            sliderVal: .constant(0),
            amplitudes: testBits3,
            waveformColor: .appPurple,
            imageName: "noteIcon",
            beatsName: "Beat’s Name",
            beatsKey: "Beat’s Key"
        )
        .background(Color.black)
    }
}

struct AudioCell_Prewiew2: PreviewProvider {
    static var previews: some View {
        AudioCell(
            unfoldingLevel: .constant(.half),
            sliderVal: .constant(0),
            amplitudes: testBits3,
            waveformColor: .appLightGreen,
            imageName: "noteIcon",
            beatsName: "Beat’s Name",
            beatsKey: "Beat’s Key"
        )
        .background(Color.black)
    }
}

struct AudioCell_Prewiew3: PreviewProvider {
    static var previews: some View {
        AudioCell(
            unfoldingLevel: .constant(.fully),
            sliderVal: .constant(0),
            amplitudes: testBits3,
            waveformColor: .appLightBlue,
            imageName: "noteIcon",
            beatsName: "Beat’s Name",
            beatsKey: "Beat’s Key"
        )
        .background(Color.black)
    }
}
