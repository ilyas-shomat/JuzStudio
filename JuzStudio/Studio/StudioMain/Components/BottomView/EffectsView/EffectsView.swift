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
