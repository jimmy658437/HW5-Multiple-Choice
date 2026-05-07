//
//  StartView.swift
//  HW #5 Multiple Choice
//
//  Created by 114-2Workshop12 on 2026/5/7.
//


import SwiftUI

struct StartView: View {
    let onStart: () -> Void
    var body: some View {
        
        ZStack {
            Image(.startBackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 10)
            Color.white.opacity(0.5)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                Image(systemName: "car.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                Text("汽車知識測驗")
                    .font(.largeTitle).bold()
                Text("挑戰 10 題專業知識")
                    .font(.subheadline)
                Button(action: onStart) {
                    Text("開始遊戲")
                        .font(.title2).bold()
                        .frame(width: 200, height: 60)
                        .glassEffect(.clear)
                        .foregroundColor(.black)
                        .cornerRadius(15)
                }
            }
        }
    }
}

#Preview {
    StartView(onStart: {})
}
