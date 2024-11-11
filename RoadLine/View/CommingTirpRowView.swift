//
//  CommingTirpRowView.swift
//  RoadLine
//
//  Created by 최서희 on 11/7/24.
//

import SwiftUI

struct CommingTirpRowView: View {
    @EnvironmentObject var travelViewModel: TravelViewModel
    let travelID: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.black.opacity(0.8))
            .shadow(radius: 10)
            .frame(width: .infinity, height: 160)
            .overlay(
                VStack(spacing: 6) {
                    HStack(spacing: 6) {
                        Text(travelViewModel.getTravel(by: travelID)?.country ?? "")
                            .font(.title2)
                            .bold()
                    }
                    
                    Text("\(travelViewModel.getTravel(by: travelID)?.departureDate.dateToString(format: .yyyyMMddDot) ?? "") - \(travelViewModel.getTravel(by: travelID)?.returnDate.dateToString(format: .yyyyMMddDot) ?? "")")
                        .font(.subheadline)
                }
                .foregroundStyle(.white)
            )
    }
}

#Preview {
    CommingTirpRowView(travelID: "0")
        .environmentObject(TravelViewModel())
}
