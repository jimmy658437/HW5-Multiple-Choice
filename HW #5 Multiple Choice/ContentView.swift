//
//  ContentView.swift
//  HW #5 Multiple Choice
//
//  Created by 114-2Workshop12 on 2026/5/7.
//

import SwiftUI

struct ContentView: View {

    @State private var gameStatus = "start"
    @State private var score = 0
    @State private var currentQuestions: [Question] = []

    var body: some View {

        VStack {

            if gameStatus == "start" {

                StartView(onStart: startNewGame)

            } else if gameStatus == "playing" {

                GameView(
                    questions: currentQuestions,
                    score: $score,
                    onFinish: {
                        gameStatus = "result"
                    }
                )

            } else {

                ResultView(
                    finalScore: score,
                    onRestart: startNewGame
                )
            }
        }
    }

    func startNewGame() {

        // 從題庫亂數抽 10 題
        currentQuestions = Array(
            QuestionProvider.allQuestions
                .shuffled()
                .prefix(10)
        )

        score = 0
        gameStatus = "playing"
    }
}

#Preview {
    ContentView()
}
