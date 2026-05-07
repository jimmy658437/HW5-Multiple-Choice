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
        VStack(spacing: 25) {
            Text("測驗結束")
                .font(.title)
            Text("\(finalScore)")
                .font(.system(size: 100, weight: .black))
                .foregroundColor(finalScore >= 100 ? .green : .red)
            Text("最終得分")
            
            Button(action: onRestart) {
                Text("再玩一次")
                    .bold()
                    .padding()
                    .frame(width: 150)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    ResultView(finalScore: 120, onRestart: {})
}