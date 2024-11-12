//
//  CommingTirpRowView.swift
//  RoadLine
//
//  Created by 최서희 on 11/7/24.
//

import SwiftUI
import RealmSwift

struct CommingTirpRowView: View {
    @EnvironmentObject var travelViewModel: TravelViewModel
    let travelID: ObjectId
    let onDelete: () -> Void
    @State private var showAlert = false
    
    var body: some View {
        HStack {
            NavigationLink(destination: TravelPlanView(travelID: travelID)) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.primary)
                    .shadow(radius: 10)
                    .frame(width: .infinity, height: 160)
                    .overlay(
                        VStack(spacing: 6) {
                            Text(travelViewModel.getTravel(by: travelID)?.country ?? "")
                                .font(.title2)
                                .bold()
                            
                            Text("\(travelViewModel.getTravel(by: travelID)?.departureDate.dateToString(format: .yyyyMMddDot) ?? "") - \(travelViewModel.getTravel(by: travelID)?.returnDate.dateToString(format: .yyyyMMddDot) ?? "")")
                                .font(.subheadline)
                        }
                            .foregroundStyle(.darkPrimary)
                    )
                    .onLongPressGesture {
                        showAlert = true
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("여행 삭제"),
                            message: Text("정말 여행을 삭제하시겠습니까?"),
                            primaryButton: .destructive(Text("Delete"), action: {
                                onDelete()
                            }),
                            secondaryButton: .cancel()
                        )
                    }
            }
        }
    }
}

