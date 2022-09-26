//
//  EffectCell.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 16.09.2022.
//

import SwiftUI

struct EffectCell: View {
    private var entity: EffectCellEntity
    
    init(entity: EffectCellEntity) {
        self.entity = entity
    }
    
    var body: some View {
        content
    }
    
    private var content: some View {
        VStack {
            circleContent
            nameLableContent
        }
    }
    
    private var circleContent: some View {
        ZStack {
            Circle()
                .frame(width: 48, height: 48, alignment: .center)
                .foregroundColor(entity.isSelected ? .appPurple : .white.opacity(0.05))
            
            Image(entity.image)
                .resizable()
                .frame(width: 48, height: 48, alignment: .center)
                .cornerRadius(24)
            
        }
    }
    
    private var nameLableContent: some View {
        Text(entity.name)
            .font(Font.system(size: 13))
            .foregroundColor(entity.isSelected ? .appDarkPurple : .white)
    }
}
