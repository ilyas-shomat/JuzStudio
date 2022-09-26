//
//  EffectsView.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 16.09.2022.
//

import SwiftUI

struct EffectsView: View {
    private var entities: [EffectCellEntity]
    private var effectsButtonTap: (EffectsPopUpType) -> Void
    
    init(
        entities: [EffectCellEntity],
        effectsButtonTap: @escaping (EffectsPopUpType) -> Void
    ) {
        self.entities = entities
        self.effectsButtonTap = effectsButtonTap
    }
    
    var body: some View {
        content
    }
    
    private var content: some View {
        HStack(spacing: 0) {
            Spacer()

            ForEach(entities, id: \.self) { entity in
                EffectCell(entity: entity)
                    .onTapGesture {
                        effectsButtonTap(entity.effectType)
                    }
                Spacer()
            }
        }
    }
}

//struct EffectsView_Previews: PreviewProvider {
//    static var previews: some View {
//        EffectsView(entities: [
//            .init(name: "Delay", image: "delay", isSelected: true),
//            .init(name: "Reverb", image: "reverb", isSelected: true),
//            .init(name: "EQ", image: "eq", isSelected: true),
//            .init(name: "Compressor", image: "compressor", isSelected: true),
//            .init(name: "R-Box", image: "rbox", isSelected: true),
//
//        ])
//        .previewLayout(.sizeThatFits)
//        .background(Color.appdarkBackground)
//    }
//}
