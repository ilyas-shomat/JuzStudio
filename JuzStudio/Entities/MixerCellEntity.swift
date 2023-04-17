//
//  MixerCellEntity.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 31.08.2022.
//

import Foundation
import SwiftUI

enum MixerType {
    case music
    case voice
    case empty
}

struct MixerCellEntity {
    var type: MixerType = .empty
    var desc1: String? = ""
    var desc2: String? = ""
    var amplitudes: [CGFloat]? 
}
