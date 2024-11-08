//
//  PastTripRowView.swift
//  RoadLine
//
//  Created by 최서희 on 11/7/24.
//

import SwiftUI

struct PastTripRowView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            Circle()
                .frame(width: 60, height: 60)
                .shadow(radius: 10)
            
            VStack(alignment: .leading, spacing: 3) {
                Text("일본 오사카")
                    .font(.headline)
                Text("2024.10.12 - 2024.10.15")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("엄마랑 언니랑 여행")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
        .frame(height: 80)
    }
}

#Preview {
    PastTripRowView()
}
