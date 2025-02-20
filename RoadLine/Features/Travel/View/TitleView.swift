//
//  TitleView.swift
//  RoadLine
//
//  Created by 최서희 on 11/7/24.
//

import SwiftUI
import ComposableArchitecture

struct TitleView: View {
    let store: StoreOf<TravelFeature>
    @State private var showSheet: Bool = false
    
    var body: some View {
        HStack {
            Button {
                // 왼쪽 메뉴 등의 액션 처리 가능 (필요 시 액션 전송)
            } label: {
                Image(systemName: "line.3.horizontal")
                    .resizable()
                    .frame(width: 20, height: 14)
            }
            
            Text("Road Line Travel")
                .font(.title)
                .bold()
                .italic()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
            
            Button {
                showSheet.toggle()
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .sheet(isPresented: $showSheet) {
                // AddTravel에 store 전달
                AddTravel(store: store)
            }
        }
        .padding(.horizontal, 16)
        .foregroundColor(.white)
        .background(Color.accentColor)
    }
}

#Preview {
    TitleView(
        store: Store(
            initialState: TravelFeature.State(),
            reducer: { TravelFeature() }
        )
    )
}
