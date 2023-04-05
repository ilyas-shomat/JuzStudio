//
//  StudioMainViewModel.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 22.02.2023.
//

import Foundation
import AVFoundation

final class StudioMainViewModel {
    var viewController: StudioMainViewControllerDelegate? {
        didSet {
            getSoundAmplitudes(urlString: audioFileUrl)
        }
    }
    private let superpoweredService: SuperpoweredService
    private let audioFileUrl: String
    
    init(audioFileUrl: String, superpoweredService: SuperpoweredService) {
        self.audioFileUrl = audioFileUrl
        self.superpoweredService = superpoweredService
        
        superpoweredService.setupMainPlayer(withPath: audioFileUrl)
        
        superpoweredService.audioCompletion = { [weak self] in
//            print("/// auddio playing completed")
            self?.viewController?.mainAudioPlayingFinished()
        }
    }
    
    private func getSoundAmplitudes(urlString: String) {
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
            
            print("amplitudes.count", amplitudes.count)
            
            let normalizedAmplitudes = getNormalizedAmplitudes(amplitudes: amplitudes)
                        
            viewController?.setFirstAmplitudes(normalizedAmplitudes)
        }
        catch {
            
        }
    }
    
    private func getNormalizedAmplitudes(amplitudes: [Float]) -> [Float] {
        var normalizedAmplitudes = [Float]()
        var i = 0
        
        while i + 882 < amplitudes.count {
//            print("i + 882:", i + 882)
            
            let subArray = Array(amplitudes[i...i + 882])
            let sum = subArray.reduce(0, +)
            let normalizedAmplitude: Float = Float(sum / 882)
            let peakAmplitude = subArray.max() ?? 0
            
            normalizedAmplitudes.append((peakAmplitude * 100).rounded() / 100)
            
            i += 882 // Base samplerate is 44100, and to reduce it to the 50, it need to iterate every 882 step
        }
        
        return normalizedAmplitudes
    }
}

extension StudioMainViewModel: StudioMainViewModelDelegate {
    func onPlayPause() {
        superpoweredService.onPlayPause()
    }
}


//class A {
//    private let b: B
//
//    init(b: B) {
//        self.b = b
//
//        b.closure = {
//
//        }
//    }
//
//
//}
//
//class B {
//    var closure: (() -> Void)?
//
//    init() {
//        closure?()
//    }
//}
