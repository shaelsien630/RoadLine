//
//  TitleView.swift
//  RoadLine
//
//  Created by 최서희 on 11/7/24.
//

import SwiftUI

struct TitleView: View {
    var body: some View {
        HStack {
            Button {
                
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
               
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
        }
        .padding(.horizontal, 16)
        .foregroundStyle(.white)
        .background(Color.accentColor)
    }
}

#Preview {
    TitleView()
}
