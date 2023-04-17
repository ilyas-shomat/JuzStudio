//
//  AudioWaveView.swift
//  JuzAudioWave
//
//  Created by Ilyas Shomat on 23.08.2022.
//

import Foundation
import SwiftUI
import Combine

struct AudioWaveView: View {
    @State var index: Int = 0
    @State var appearedIndex: Int = 0
    @State var disappearedIndex: Int = 0

    @Binding var incrementor: Int
    
    private var reader: ScrollViewProxy?

    private var bits: [CGFloat]
    private var waveColor: Color
    private var waveTapped: () -> Void
    
    init(
        incrementor: Binding<Int>,
        bits: [CGFloat],
        waveColor: Color,
        reader: ScrollViewProxy? = nil,
        waveTapped: @escaping () -> Void
    ) {
        _incrementor = incrementor
        self.bits = bits
        self.waveColor = waveColor
        self.waveTapped = waveTapped
        self.reader = reader
    }
                        
    var body: some View {
        setAudioWaveView()
            .onChange(of: incrementor) { _ in
                index += 1
                
                if index >= bits.count {
                    waveTapped()
                }
                
                reader?.scrollTo(index)
            }
            .frame(height: 84)
    }
    
    private func setAudioWaveView() -> some View {
        LazyHStack(spacing: 1) {
            ForEach(0..<bits.count, id: \.self) { i in
                setBitContent(height: bits[i] * 40)
                    .onAppear {
                        appearedIndex = i
                        index = max(index, i)
                    }
                    .onDisappear {
                        disappearedIndex = i
                        index = max(appearedIndex, disappearedIndex)
                    }
            }
        }
    }
    
    private func setBitContent(height: CGFloat) -> some View {
        Divider()
            .frame(width: StudioConstants.amplitudeWidth, height: height)
            .background(waveColor)
    }
}

struct AudioWaveView_Preview1: PreviewProvider {
    static var previews: some View {
        AudioWaveView(
            incrementor: .constant(0),
            bits: testBits1,
            waveColor: .appPurple,
            waveTapped: {}
        )
    }
}
