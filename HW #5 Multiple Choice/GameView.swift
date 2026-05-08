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

        ZStack {

            //背景
            LinearGradient(
                colors: [
                    .background,
                    .accent.opacity(0.3),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            if currentIndex < questions.count {

                VStack(spacing: 16) {

                    // 上方資訊
                    VStack(alignment: .leading, spacing: 15) {

                        HStack {

                            Text(
                                "第 \(currentIndex + 1) / \(questions.count)題"
                            )
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)

                            Spacer()

                            // 分數

                            Text("分數：\(score)")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(
                                    Capsule()
                                        .fill(Color.accentColor)
                                        .shadow(
                                            color: .black.opacity(0.2),
                                            radius: 8,
                                            x: 0,
                                            y: 4
                                        )
                                )
                        }

                        // 進度條
                        ProgressView(
                            value: Double(currentIndex + 1),
                            total: Double(questions.count)
                        )
                        .tint(
                            Color(.accent)
                        )
                        .scaleEffect(x: 1, y: 1.8)
                    }
                    .padding(.horizontal)

                    // 題目卡片
                    VStack(alignment: .leading, spacing: 14) {

                        // 圖片
                        Image(questions[currentIndex].imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 160)
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .cornerRadius(16)
                            .shadow(
                                color: .black.opacity(0.12),
                                radius: 6,
                                x: 0,
                                y: 3
                            )

                        // 題目文字
                        Text(questions[currentIndex].text)
                            .font(
                                .system(
                                    size: 17,
                                    weight: .medium
                                )
                            )
                            .foregroundColor(.black)
                            .lineSpacing(4)
                            .multilineTextAlignment(.leading)
                            .fixedSize(
                                horizontal: false,
                                vertical: true
                            )
                            .frame(
                                maxWidth: .infinity,
                                alignment: .leading
                            )
                    }
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(22)
                    .padding(.horizontal)
                    .shadow(
                        color: .black.opacity(0.05),
                        radius: 10,
                        x: 0,
                        y: 3
                    )

                    // 選項
                    VStack(spacing: 14) {

                        ForEach(shuffledOptions, id: \.self) { option in

                            Button {

                                if !isShowingAnswer {

                                    checkAnswer(option)
                                }

                            } label: {

                                HStack(alignment: .center, spacing: 14) {

                                    // A B C D 選項編號
                                    Text(optionLetter(for: option))
                                        .font(.headline.bold())
                                        .foregroundColor(
                                            selectedOption == option
                                                ? .white
                                                : Color(Color(.accent))
                                        )
                                        .frame(width: 35, height: 35)
                                        .background(
                                            selectedOption == option
                                                ? Color(.accent)
                                                : Color(
                                                    red: 0.88,
                                                    green: 0.92,
                                                    blue: 0.95
                                                )
                                        )
                                        .cornerRadius(10)

                                    // 選項文字
                                    Text(option)
                                        .font(
                                            .system(
                                                size: 16,
                                                weight: .medium
                                            )
                                        )
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(
                                            horizontal: false,
                                            vertical: true
                                        )
                                        .frame(
                                            maxWidth: .infinity,
                                            alignment: .leading
                                        )

                                    Spacer(minLength: 0)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    optionBackground(for: option)
                                )
                                .overlay(
                                    RoundedRectangle(
                                        cornerRadius: 16
                                    )
                                    .stroke(
                                        borderColor(for: option),
                                        lineWidth: 2
                                    )
                                )
                                .cornerRadius(16)
                            }
                        }
                    }
                    .padding(.horizontal)

                    // 回饋文字
                    if isShowingAnswer {

                        Text(feedbackText)
                            .font(.subheadline.bold())
                            .foregroundColor(
                                feedbackText.contains("可惜")
                                    ? .red
                                    : .green
                            )
                    }

                    Spacer(minLength: 0)

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
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(Color(.accent))
                            .cornerRadius(16)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 10)
            }
        }
        .onAppear {

            refreshOptions()
        }
    }

    // MARK: - 選項背景色

    func optionBackground(for option: String) -> Color {

        if !isShowingAnswer {

            return .white
        }

        let correct = questions[currentIndex].correctAnswer

        if option == correct {

            return Color.green.opacity(0.22)

        } else if option == selectedOption {

            return Color.red.opacity(0.22)

        } else {

            return .white
        }
    }

    // MARK: - 外框顏色

    func borderColor(for option: String) -> Color {

        let correct = questions[currentIndex].correctAnswer

        if isShowingAnswer {

            if option == correct {

                return .green

            } else if option == selectedOption {

                return .red

            } else {

                return .clear
            }

        } else {

            return .clear
        }
    }

    // MARK: - A B C D

    func optionLetter(for option: String) -> String {

        guard let index = shuffledOptions.firstIndex(of: option)
        else {
            return ""
        }

        let letters = ["A", "B", "C", "D"]

        return letters[index]
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
                feedbackText = "太厲害了，連對三題 +30"

            } else {

                score += 10
                feedbackText = "答對了 +10"
            }

        } else {

            score -= 10
            streakCount = 0
            feedbackText = "真是太可惜，再接再厲"
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
