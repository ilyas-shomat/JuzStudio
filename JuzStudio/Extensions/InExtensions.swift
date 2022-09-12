//
//  InExtensions.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 05.09.2022.
//

import Foundation
import UIKit


//        MARK: - Values 375, 812 taken from Iphone 11's size. Reason: App's base design constructed for this type decvice
extension Int {
    var deviceHeightRatioValue: CGFloat {
        return CGFloat(self) * UIScreen.main.bounds.height / 812
    }
    
    var deviceWidthRatioValue: CGFloat {
        return CGFloat(self) * UIScreen.main.bounds.width / 375
    }
}

extension Int {
    enum SafeAreaInset {
        case top
        case bottom
    }
    
    func withSafeAreaInset(_ inset: SafeAreaInset) -> CGFloat {
        guard let window = UIApplication.shared.windows.first else {
            return 0
        }
        let topPadding = window.safeAreaInsets.top
        let bottomPadding = window.safeAreaInsets.bottom
        
        switch inset {
        case .top:
            return CGFloat(self) + topPadding
        case .bottom:
            return CGFloat(self) + bottomPadding
        }
    }
}

extension Int {
    var numberString: String {
        guard self < 10 else { return "0" }
        return String(self)
    }
}

