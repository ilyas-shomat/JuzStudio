//
//  AppSlider.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 07.09.2022.
//

import Foundation
import UIKit
import SwiftUI

struct AppSlider: UIViewRepresentable {
    final class Coordinator: NSObject {
        var value: Binding<Double>
        
        init(value: Binding<Double>) {
            self.value = value
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            self.value.wrappedValue = Double(sender.value)
        }
    }
    
    var thumbColor: UIColor = .white
    var minTrackColor: UIColor?
    var maxTrackColor: UIColor?
    
    @Binding var value: Double
    
    func makeUIView(context: Context) -> UISlider {
        let thumb = UIView()
        thumb.backgroundColor = thumbColor
        
        let slider = UISlider(frame: .zero)
        slider.setThumbImage(thumbImage(thumb, radius: 16), for: .normal)
        slider.minimumTrackTintColor = minTrackColor
        slider.maximumTrackTintColor = maxTrackColor
        slider.value = Float(value)
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(self.value)
    }
    
    func makeCoordinator() -> AppSlider.Coordinator {
        Coordinator(value: $value)
    }
    
    private func thumbImage(_ thumbView: UIView, radius: CGFloat) -> UIImage {
        thumbView.frame = CGRect(x: 0, y: radius / 2, width: radius, height: radius)
        thumbView.layer.cornerRadius = radius / 2
        
        
        let renderer = UIGraphicsImageRenderer(bounds: thumbView.bounds)
        
        return renderer.image { rendererContext in
            thumbView.layer.render(in: rendererContext.cgContext)
        }
    }
}
