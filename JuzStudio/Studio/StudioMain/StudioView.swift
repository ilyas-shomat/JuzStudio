//
//  StudioView.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 17.04.2023.
//

import SwiftUI

struct StudioView: View {
    @ObservedObject private var viewController: StudioScene
    
    init(_ viewController: StudioScene) {
        self.viewController = viewController
    }
    
    var body: some View {
        setupAudioCells()
    }
    
    private func setupAudioCells() -> some View {
        VStack(spacing: 5) {
            AudioCell(
                unfoldingLevel: .constant(.zero),
                sliderVal: .constant(0),
                amplitudes: testBits3,
                waveformColor: .appPurple,
                imageName: "noteIcon",
                beatsName: "Beat’s Name",
                beatsKey: "Beat’s Key"
            )
            AudioCell(
                unfoldingLevel: .constant(.zero),
                sliderVal: .constant(0),
                amplitudes: testBits3,
                waveformColor: .appPurple,
                imageName: "noteIcon",
                beatsName: "Beat’s Name",
                beatsKey: "Beat’s Key"
            )
            AudioCell(
                unfoldingLevel: .constant(.zero),
                sliderVal: .constant(0),
                amplitudes: testBits3,
                waveformColor: .appPurple,
                imageName: "noteIcon",
                beatsName: "Beat’s Name",
                beatsKey: "Beat’s Key"
            )
        }
    }
    
}

struct StudioView_Previews: PreviewProvider {
    static var previews: some View {
        StudioView(.init())
    }
}
