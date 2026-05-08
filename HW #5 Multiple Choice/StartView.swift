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
            //背景加模糊
            Image(.startBackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 10)
            //白色遮罩
            Color.white.opacity(0.7)
                .ignoresSafeArea()
            
            VStack(spacing: 80) {
                VStack{
                    Text("汽車知識測驗")
                        .font(.largeTitle)
                        .bold()
                    
                    Image(.startPhoto)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 230)
                        .cornerRadius(16)
                        .shadow(
                            color: .black.opacity(0.12),
                            radius: 6,
                            x: 0,
                            y: 3
                        )
                }
                
                Button(action: onStart) {
                    Text("開始遊戲")
                        .font(.title2).bold()
                        .frame(width: 200, height: 60)
                        .glassEffect(.clear)
                        .foregroundColor(.black)
                        .cornerRadius(15)
                }
            }
            .offset(y:-20)
        }
    }
}

#Preview {
    StartView(onStart: {})
}
