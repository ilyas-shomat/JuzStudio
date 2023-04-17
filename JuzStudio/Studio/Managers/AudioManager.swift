//
//  AudioManager.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 07.04.2023.
//

import Foundation
import AVFoundation

final class AudioManager {    
    var audiosUrlsString: [String] = .init()
    var error: Error?
    
    init() {}
    
    func getSoundAmplitudes() -> [[CGFloat]] {
        var amplitudesList: [[CGFloat]] = .init()
        
        for urlString in audiosUrlsString {
            amplitudesList.append(
                getExactAmplitudes(urlString)
                    .map { CGFloat($0) }
            )
        }
        
        return amplitudesList
    }
    
    private func getExactAmplitudes(_ urlString: String) -> [Float] {
        var finalAmplitudes: [Float] = .init()
        
        do {
            let audioFile = try AVAudioFile(forReading: URL(fileURLWithPath: urlString))
            
            // Get the audio format
            let audioFormat = audioFile.processingFormat

            // Get the audio buffer
            let audioBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: AVAudioFrameCount(audioFile.length))
            try audioFile.read(into: audioBuffer!)

            // Get the channel data
            let channelData = audioBuffer!.floatChannelData![0]

            // Calculate the amplitudes
            let sampleCount = Int(audioBuffer!.frameLength)
            var amplitudes = [Float](repeating: 0.0, count: sampleCount)
            for i in 0..<sampleCount {
                amplitudes[i] = abs(channelData[i])
            }
                        
            finalAmplitudes = getNormalizedAmplitudes(amplitudes: amplitudes)
        }
        catch(let error) {
            self.error = error
        }
        
        return finalAmplitudes
    }
    
    private func getNormalizedAmplitudes(amplitudes: [Float]) -> [Float] {
        var normalizedAmplitudes = [Float]()
        var i = 0
        
        // Base samplerate is 44100, and to reduce it to the 50, need to iterate every 882 step
        while i + 882 < amplitudes.count {
            let subArray = Array(amplitudes[i...i + 882])
            let sum = subArray.reduce(0, +)
            let peakAmplitude = subArray.max() ?? 0
            
            normalizedAmplitudes.append((peakAmplitude * 100).rounded() / 100)
            
            i += 882
        }
        
        return normalizedAmplitudes
    }
    
}
