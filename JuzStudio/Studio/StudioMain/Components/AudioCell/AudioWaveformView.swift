//
//  AudioWaveformView.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 17.04.2023.
//

import SwiftUI

struct AudioWaveformView: View {
    private let amplitudes: [CGFloat]
    private let waveColor: Color
    
    init(amplitudes: [CGFloat], waveColor: Color) {
        self.amplitudes = amplitudes
        self.waveColor = waveColor
    }
    
    var body: some View {
        setupSticks()
    }
    
    private func setupSticks() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 1) {
                ForEach(0..<amplitudes.count, id: \.self) { i in
                    Divider()
                        .frame(width: StudioConstants.amplitudeWidth, height: 40 * amplitudes[i])
                        .background(waveColor)
                }
            }
        }
        .frame(height: 80)
    }
}

struct AudioWaveformCell_Previews: PreviewProvider {
    static var previews: some View {
        AudioWaveformView(amplitudes: testBits3, waveColor: .appPurple)
            .previewLayout(.sizeThatFits)
    }
}
