//
//  ResultView.swift
//  HW #5 Multiple Choice
//
//  Created by 114-2Workshop12 on 2026/5/7.
//


import SwiftUI

struct ResultView: View {
    let finalScore: Int
    let onRestart: () -> Void
    var body: some View {
        
        ZStack {
            //背景加模糊
            Image(.resultBackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 10)
                .offset(x: -250)
            
            //白色遮罩
            Color.white.opacity(0.7)
                .ignoresSafeArea()
            
            VStack(spacing: 70) {
                VStack(alignment: .center, spacing: 14) {
                    
                    Text("最終得分")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.accent)
                    Text("\(finalScore)")
                        .font(.system(size: 80, weight: .black))
                        .foregroundColor(finalScore >= 100 ? .green : .red)
                    
                }
                .frame(width: 300, height: 200)
                .padding(5)
                .background(.thinMaterial)
                .cornerRadius(22)
                .padding(.horizontal)
                .shadow(color: .black.opacity(0.1),
                        radius: 10,
                        x: 0,
                        y: 3
                )
                
                
                Button(action: onRestart) {
                    Text("再玩一次")
                        .padding()
                        .font(.title2).bold()
                        .frame(width: 200, height: 60)
//                        .background(Capsule().fill(.accent))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .buttonStyle(.glassProminent)
            }
        }
    }
}

#Preview {
    ResultView(finalScore: 120, onRestart: {})
}
