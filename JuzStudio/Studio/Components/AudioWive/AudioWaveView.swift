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

    private var bits: [CGFloat]
    private var waveColor: Color
    private var waveTapped: () -> Void
    
    init(
        incrementor: Binding<Int>,
        bits: [CGFloat],
        waveColor: Color,
        setLastIndex: @escaping () -> Void
    ) {
        _incrementor = incrementor
        self.bits = bits
        self.waveColor = waveColor
        self.waveTapped = setLastIndex
        
    }
                        
    var body: some View {
        ScrollViewReader { reader in
            ScrollView(.horizontal, showsIndicators: false) {
                setAudioWaveView()
                    .frame(height: 40)
            }
            .onChange(of: incrementor) { _ in
                index += 1
                reader.scrollTo(index)
            }
            .simultaneousGesture(
                DragGesture()
                    .onChanged { gesture in
                        waveTapped()
                    }
            )
        }
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
            .frame(width: StudioConstants.amplitudeWeight, height: height)
            .background(waveColor)
    }
}
