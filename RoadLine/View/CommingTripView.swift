//
//  CommingTripView.swift
//  RoadLine
//
//  Created by 최서희 on 11/7/24.
//

import SwiftUI

struct CommingTripView: View {
    var body: some View {
        VStack(spacing: 15) {
            Text("다가오는 여행")
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(0..<1, id: \.self) { _ in
                CommingTirpRowView()
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 20)
        .padding(.bottom, 24)
    }
}

#Preview {
    CommingTripView()
}
