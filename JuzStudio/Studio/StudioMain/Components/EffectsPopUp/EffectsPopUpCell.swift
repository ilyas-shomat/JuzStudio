//
//  EffectsPopUpCell.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 19.09.2022.
//

import SwiftUI

struct EffectsPopUpCell: View {
    @State private var slidingval: Double = 0

    @Binding private var type: EffectsPopUpType
    @Binding private var typeDict: [EffectsPopUpType: [EffectsPopUpCellEntity]]
    
    private var index: Int

    private var val: Double {
        if let val = typeDict[type]?[index].value {
            return val
        }
        else {
            return .init()
        }
    }
    
    private var minVal: Double {
        if let minVal = typeDict[type]?[index].minVal {
            return minVal
        }
        else {
            return .init()
        }
    }
    
    private var maxVal: Double {
        if let maxVal = typeDict[type]?[index].maxVal {
            return maxVal
        }
        else {
            return .init()
        }
    }
    
    init(
        type: Binding<EffectsPopUpType>,
        typeDict: Binding<[EffectsPopUpType : [EffectsPopUpCellEntity]]>,
        index: Int
    ) {
        _type = type
        _typeDict = typeDict
        
        self.index = index
    }
    
    var body: some View {
        content
    }
    
    private var content: some View {
        VStack {
            HStack {
                Text(typeDict[type]?[index].name ?? "")
                    .foregroundColor(.appDarkPurple)
                Spacer()
                Text("\(val.removeZerosFromEnd())%")
                    .foregroundColor(.white)
            }
            slider
        }
        .onChange(of: slidingval) { newValue in
            typeDict[type]?[index].value = getCurrentVal(value: newValue)
        }
        .onAppear {
            slidingval = getBaseCurrentVal(value: val)
        }
    }
    
    private var slider: some View {
        AppSlider(
            thumbColor: .white,
            minTrackColor: .appPurple,
            maxTrackColor: .appPurple.withAlphaComponent(0.5),
            value: $slidingval
        )
    }
    
    private func getCurrentVal(value: Double) -> Double {
        return value * (maxVal - minVal) + minVal
    }
    
    private func getBaseCurrentVal(value: Double) -> Double {
        return (value - minVal)/(maxVal - minVal)
    }
}
