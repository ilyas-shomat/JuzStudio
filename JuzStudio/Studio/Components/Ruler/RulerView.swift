//
//  RulerView.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 07.09.2022.
//

import Foundation
import SwiftUI

struct RulerView: View {
    var body: some View {
        ScrollViewReader { reader in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 21) {
                    ForEach (0..<100, id: \.self) { i in
                        if i % 4 == 0 {
                            setStripe(height: 24,value: "\(Int(i/4) + 1)")
                        }
                        else {
                            setStripe(height: 8)
                        }
                    }
                }
            }
        }
        .background(Color.appWhiteWithOpacity)
        .frame(height: 24)
    }
    
    private func setStripe(
        height: CGFloat,
        value: String? = nil
    ) -> some View {
        if let value = value {
            return AnyView(
                HStack(spacing: 3) {
                    Divider()
                        .frame(width: 1, height: height)
                        .background(.white)
                    
                    VStack {
                        Text(value)
                            .foregroundColor(.white)
                            .font(.system(size: 11))
                        Spacer()
                    }
                }
            )
        }
        else {
            return AnyView(
                VStack {
                    Spacer()
                    HStack {
                        Divider()
                            .frame(width: 1, height: height)
                            .background(.white)
                            .padding(.trailing, 6)
                    }
                }
            )
        }
    }
}


struct RulerView_Previews: PreviewProvider {
    static var previews: some View {
        RulerView()
        .previewLayout(.sizeThatFits)
        .padding()
        .background(.black)
    }
}
