//
//  PastTripRowView.swift
//  RoadLine
//
//  Created by 최서희 on 11/7/24.
//

import SwiftUI

struct PastTripRowView: View {
    @EnvironmentObject var travelViewModel: TravelViewModel
    let travelID: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            Circle()
                .frame(width: 60, height: 60)
                .shadow(radius: 10)
                .foregroundStyle(Color.primary) // 원래는 이미지 들어가야함
            
            VStack(alignment: .leading, spacing: 3) {
                Text(travelViewModel.getTravel(by: travelID)?.country ?? "")
                    .font(.headline)
                    .foregroundStyle(Color.primary)
                Text("\(travelViewModel.getTravel(by: travelID)?.departureDate.dateToString(format: .yyyyMMddDot) ?? "") - \(travelViewModel.getTravel(by: travelID)?.returnDate.dateToString(format: .yyyyMMddDot) ?? "")")
                    .font(.caption)
                    .foregroundStyle(Color.gray)
                Text(travelViewModel.getTravel(by: travelID)?.notes ?? "")
                    .font(.caption2)
                    .foregroundStyle(Color.gray)
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
        .frame(height: 80)
    }
}

#Preview {
    PastTripRowView(travelID: "0")
        .environmentObject(TravelViewModel())
}
