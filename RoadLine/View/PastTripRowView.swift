//
//  PastTripRowView.swift
//  RoadLine
//
//  Created by 최서희 on 11/7/24.
//

import SwiftUI

struct PastTripRowView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            Circle()
                .frame(width: 75, height: 75)
                .shadow(radius: 10)
            
            VStack(alignment: .leading, spacing: 3) {
                Text("일본 오사카")
                    .font(.title3)
                Text("2024.10.12 - 2024.10.15")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("엄마랑 언니랑 여행")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
        .frame(height: 100)
        // .padding(.horizontal, 24) // 외부에서 선언
    }
}

#Preview {
    PastTripRowView()
}
