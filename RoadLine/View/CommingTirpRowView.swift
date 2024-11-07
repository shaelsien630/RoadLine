//
//  CommingTirpRowView.swift
//  RoadLine
//
//  Created by 최서희 on 11/7/24.
//

import SwiftUI

struct CommingTirpRowView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.black.opacity(0.8))
            .shadow(radius: 10)
            .frame(width: .infinity, height: 160)
            .overlay(
                VStack(spacing: 6) {
                    Text("태국 푸켓")
                        .font(.title2)
                        .bold()
                    Text("2024.10.12 - 2024.10.15")
                        .font(.subheadline)
                }
                .foregroundStyle(.white)
            )
    }
}

#Preview {
    CommingTirpRowView()
}
