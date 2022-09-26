//
//  LyricsView.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 26.09.2022.
//

import SwiftUI

struct LyricsView: View {
    var body: some View {
        content
    }
    
    private var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    Text("Lose Yourself")
                        .font(Font.system(size: 28))
                    Spacer()
                }
                Text(
                    "Yo His palms are sweaty, knees weak, arms are heavy There's vomit on his sweater already, mom's spaghetti He's nervous, but on the surface he looks calm and ready To drop bombs, but he keeps on forgettin' What he wrote down, the whole crowd goes so loud"
                    +
                    "Yo His palms are sweaty, knees weak, arms are heavy There's vomit on his sweater already, mom's spaghetti He's nervous, but on the surface he looks calm and ready To drop bombs, but he keeps on forgettin' What he wrote down, the whole crowd goes so loud"
                )
                .padding(.top, 24)
            }
            .frame(alignment: .leading)
            .foregroundColor(.white)
        }
        .padding(.horizontal, 24)
        .padding(.top, 24)
    }
}

struct LyricsView_Previews: PreviewProvider {
    static var previews: some View {
        LyricsView()
            .background(Color.appdarkBackground)
    }
}
