# SwiftUI 題目圖片版 GameView

下面這個版本會：

- 在 GameView 上方新增圖片區塊
- 圖片有：
  - 圓角
  - 陰影
- 根據不同題目主題自動切換照片

---

# 第一步：修改 Question.swift

你現在的 Question 結構只有：

```swift
struct Question {
    let text: String
    let options: [String]
    let correctAnswer: String
}
```

改成下面這個版本：

```swift
import Foundation

struct Question {

    let text: String
    let options: [String]
    let correctAnswer: String

    // 新增主題分類
    let category: String

    // 新增圖片名稱
    let imageName: String
}
```

---

# 第二步：修改 QuestionProvider.swift

每一題新增：

- category
- imageName

例如：

```swift
Question(
    text: "四行程引擎的運作循環順序為何？",
    options: ["進氣-壓縮-動力-排氣", "進氣-動力-壓縮-排氣", "進氣-排氣-壓縮-動力", "壓縮-進氣-動力-排氣"],
    correctAnswer: "進氣-壓縮-動力-排氣",
    category: "Engine",
    imageName: "engine"
)
```

再例如：

```swift
Question(
    text: "CVT 無段變速箱主要是靠什麼來改變傳動比？",
    options: ["齒輪組換檔", "鋼帶與普利盤幅徑", "離合器片摩擦", "扭力轉換器"],
    correctAnswer: "鋼帶與普利盤幅徑",
    category: "Transmission",
    imageName: "cvt"
)
```

ADAS 題目：

```swift
Question(
    text: "ADAS 中的 ACC 系統是指什麼功能？",
    options: ["自動煞車", "主動式車距調節巡航", "車道偏移輔助", "盲點偵測"],
    correctAnswer: "主動式車距調節巡航",
    category: "ADAS",
    imageName: "adas"
)
```

---

# 第三步：把圖片放進 Assets

Xcode 左邊：

```text
Assets.xcassets
```

新增圖片：

- engine
- cvt
- adas
- suspension
- hybrid

圖片名稱一定要和 imageName 一樣。

---

# 第四步：完整 GameView.swift

直接用下面這份。

```swift
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

            if currentIndex < questions.count {

                // MARK: - 題目圖片區

                Image(questions[currentIndex].imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 320, height: 180)
                    .clipped()
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 5)
                    .padding(.top)

                // MARK: - 題目資訊

                VStack(spacing: 10) {

                    HStack {

                        Text("第 \(currentIndex + 1) / \(questions.count) 題")

                        Spacer()

                        Text("得分：\(score)")
                            .bold()
                    }

                    // 顯示主題
                    Text("主題：\(questions[currentIndex].category)")
                        .font(.subheadline)
                        .foregroundColor(.blue)

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
                .padding(.horizontal)

                // MARK: - 題目

                Text(questions[currentIndex].text)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(minHeight: 100)

                // MARK: - 選項

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
                                .cornerRadius(12)
                        }
                    }
                }
                .padding(.horizontal)

                // MARK: - 下一題按鈕

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
                        .frame(width: 160, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
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
```

---

# 建議圖片主題

你可以準備這些圖片：

| 主題 | 圖片名稱 |
|---|---|
| 引擎 | engine |
| CVT | cvt |
| 懸吊 | suspension |
| ADAS | adas |
| 油電 | hybrid |

---

# 完成後效果

你的 App 會變成：

- 每題上方都有不同照片
- 題目會依主題切換圖片
- UI 更像真正測驗 App
- 有卡片感
- 圓角 + 陰影更有質感

