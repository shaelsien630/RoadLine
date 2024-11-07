//
//  PastTripView.swift
//  RoadLine
//
//  Created by 최서희 on 11/7/24.
//

import SwiftUI

struct PastTripView: View {
    var body: some View {
        VStack {
            Text("지난 여행")
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                
            ForEach(0..<4, id: \.self) { _ in
                PastTripRowView()
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 20)
    }
}

#Preview {
    PastTripView()
}
