//
//  PastTripRowView.swift
//  RoadLine
//
//  Created by 최서희 on 11/7/24.
//

import SwiftUI
import RealmSwift

struct PastTripRowView: View {
    @EnvironmentObject var travelViewModel: TravelViewModel
    let travelID: ObjectId
    let onDelete: () -> Void
    
    @State private var offsetX: CGFloat = 0
    @GestureState private var isDragging = false
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut) {
                        offsetX = 0
                    }
                    onDelete()
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                }
            }
            
            HStack {
                NavigationLink(destination: TravelPlanView(travelID: travelID)) {
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
            .padding(.horizontal, 12)
            .background(Color.white)
            .offset(x: offsetX)
            .highPriorityGesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.width < 0 {
                            offsetX = value.translation.width
                        }
                    }
                    .onEnded { value in
                        if value.translation.width < -100 {
                            withAnimation {
                                offsetX = -60
                            }
                        } else {
                            withAnimation {
                                offsetX = 0
                            }
                        }
                    }
            )
            .onAppear() {
                withAnimation {
                    offsetX = 0
                }
            }
        }
    }
}
