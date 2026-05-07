//
//  GameView.swift
//  HW #5 Multiple Choice
//
//  Created by 114-2Workshop12 on 2026/5/7.
//


import SwiftUI

struct GameView: View {

    let questions: [Question]

    @Binding var score: Int

    let onFinish: () -> Void

    @State private var currentIndex = 0
    @State private var streakCount = 0
    @State private var shuffledOptions: [String] = []

    @State private var selectedOption: String? = nil
    @State private var feedbackText = ""
    @State private var isShowingAnswer = false

    var body: some View {

        VStack(spacing: 20) {

            // 安全檢查
            if currentIndex < questions.count {

                VStack(spacing: 10) {

                    HStack {

                        Text("第 \(currentIndex + 1) / \(questions.count) 題")

                        Spacer()

                        Text("得分：\(score)")
                            .bold()
                    }

                    Text(feedbackText)
                        .font(.title3)
                        .bold()
                        .foregroundColor(
                            feedbackText.contains("可惜")
                            ? .red
                            : .green
                        )
                        .frame(height: 30)
                }
                .padding()

                // 題目
                Text(questions[currentIndex].text)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(minHeight: 120)

                // 選項
                VStack(spacing: 12) {

                    ForEach(shuffledOptions, id: \.self) { option in

                        Button {

                            if !isShowingAnswer {
                                checkAnswer(option)
                            }

                        } label: {

                            Text(option)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(buttonColor(for: option))
                                .foregroundColor(
                                    isShowingAnswer
                                    ? .white
                                    : .primary
                                )
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal)

                // 下一題
                if isShowingAnswer {

                    Button {

                        goToNextQuestion()

                    } label: {

                        Text(
                            currentIndex < questions.count - 1
                            ? "下一題"
                            : "查看結果"
                        )
                        .bold()
                        .frame(width: 150, height: 45)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding(.top, 20)
                }

                Spacer()
            }
        }
        .onAppear {
            refreshOptions()
        }
    }

    // MARK: - 按鈕顏色

    func buttonColor(for option: String) -> Color {

        if !isShowingAnswer {
            return Color.gray.opacity(0.1)
        }

        let correct = questions[currentIndex].correctAnswer

        if option == correct {

            return .green

        } else if option == selectedOption {

            return .red

        } else {

            return Color.gray.opacity(0.1)
        }
    }

    // MARK: - 檢查答案

    func checkAnswer(_ selected: String) {

        selectedOption = selected
        isShowingAnswer = true

        let correct = questions[currentIndex].correctAnswer

        if selected == correct {

            streakCount += 1

            if streakCount >= 3 {

                score += 30
                feedbackText = "太厲害了 +30"

            } else {

                score += 10
                feedbackText = "答對了 +10"
            }

        } else {

            score -= 10
            streakCount = 0
            feedbackText = "真是太可惜了，再接再厲"
        }
    }

    // MARK: - 下一題

    func goToNextQuestion() {

        if currentIndex < questions.count - 1 {

            currentIndex += 1

            selectedOption = nil
            isShowingAnswer = false
            feedbackText = ""

            refreshOptions()

        } else {

            onFinish()
        }
    }

    // MARK: - 更新選項

    func refreshOptions() {

        guard currentIndex < questions.count else {
            return
        }

        shuffledOptions =
            questions[currentIndex]
            .options
            .shuffled()
    }
}

#Preview {

    GameView(
        questions: Array(
            QuestionProvider.allQuestions.prefix(10)
        ),
        score: .constant(0),
        onFinish: {}
    )
}