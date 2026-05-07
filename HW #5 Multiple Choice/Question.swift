//
//  Question.swift
//  HW #5 Multiple Choice
//
//  Created by 114-2Workshop12 on 2026/5/7.
//


import Foundation

struct Question {
    let text: String
    let options: [String]
    let correctAnswer: String
}

struct QuestionProvider {
    static let allQuestions: [Question] = [
        // --- 引擎系統 (Engine) ---
        Question(text: "四行程引擎的運作循環順序為何？", options: ["進氣-壓縮-動力-排氣", "進氣-動力-壓縮-排氣", "進氣-排氣-壓縮-動力", "壓縮-進氣-動力-排氣"], correctAnswer: "進氣-壓縮-動力-排氣"),
        Question(text: "渦輪增壓器（Turbocharger）主要是利用什麼來驅動葉片？", options: ["皮帶帶動", "引擎排氣", "電力馬達", "機油壓力"], correctAnswer: "引擎排氣"),
        Question(text: "引擎中的「中冷器」（Intercooler）主要作用為何？", options: ["降低機油溫度", "降低進氣溫度增加含氧量", "冷卻水箱精", "冷卻排氣管"], correctAnswer: "降低進氣溫度增加含氧量"),
        Question(text: "所謂的「壓縮比」是指氣缸哪個體積的比值？", options: ["最大體積與最小體積", "進氣量與排氣量", "活塞直徑與衝程", "油箱與氣缸"], correctAnswer: "最大體積與最小體積"),
        Question(text: "哪種型式的引擎運作時，活塞是採對向水平作動，重心最低？", options: ["直列式", "V型", "水平對臥式", "轉子引擎"], correctAnswer: "水平對臥式"),
        Question(text: "火星塞（Spark Plug）在柴油引擎中的作用為何？", options: ["點燃油氣", "噴射燃料", "柴油引擎不需火星塞", "預熱氣缸"], correctAnswer: "柴油引擎不需火星塞"),

        // --- 變速箱系統 (Gearbox/Transmission) ---
        Question(text: "CVT 無段變速箱主要是靠什麼來改變傳動比？", options: ["齒輪組換檔", "鋼帶與普利盤幅徑", "離合器片摩擦", "扭力轉換器"], correctAnswer: "鋼帶與普利盤幅徑"),
        Question(text: "雙離合器變速箱（DCT）的主要優點是什麼？", options: ["換檔極快且動力流失少", "構造簡單成本低", "不需要變速箱油", "重量最輕"], correctAnswer: "換檔極快且動力流失少"),
        Question(text: "自排變速箱中的「扭力轉換器」是用來取代手排車的什麼零件？", options: ["排檔桿", "離合器", "飛輪", "同步齒圈"], correctAnswer: "離合器"),
        Question(text: "當車輛進入「超比檔」（Overdrive）時，傳動比通常是？", options: ["大於 1", "等於 1", "小於 1", "等於 0"], correctAnswer: "小於 1"),
        Question(text: "差速器（Differential）的主要功能為何？", options: ["增加馬力", "讓過彎時內外輪有轉速差", "鎖定輪胎不打滑", "改變引擎轉速"], correctAnswer: "讓過彎時內外輪有轉速差"),

        // --- 懸吊系統 (Suspension) ---
        Question(text: "哪種懸吊系統結構簡單、佔空間小，常廣泛用於小車前懸吊？", options: ["麥花臣 (MacPherson)", "多連桿 (Multi-link)", "雙 A 臂 (Double Wishbone)", "葉片彈簧"], correctAnswer: "麥花臣 (MacPherson)"),
        Question(text: "降低「簧下重量」（Unsprung Weight）對車輛有什麼好處？", options: ["增加載重能力", "提升操控反應與貼地性", "讓避震器更硬", "省油"], correctAnswer: "提升操控反應與貼地性"),
        Question(text: "防傾桿（Anti-roll Bar）主要在什麼情況下發揮作用？", options: ["直線加速", "車輛過彎傾斜時", "遇到坑洞跳動時", "緊急煞車時"], correctAnswer: "車輛過彎傾斜時"),
        Question(text: "避震器（Shock Absorber）的內部阻尼主要用來幹嘛？", options: ["支撐車重", "吸收彈簧餘振", "調整車身高度", "增加輪胎抓地力"], correctAnswer: "吸收彈簧餘振"),
        Question(text: "雙 A 臂懸吊（Double Wishbone）相較於麥花臣的優勢在於？", options: ["零件較少", "成本較低", "能更精準控制輪胎幾何", "佔用空間小"], correctAnswer: "能更精準控制輪胎幾何"),

        // --- ADAS 主動安全與電控 ---
        Question(text: "ADAS 中的 ACC 系統是指什麼功能？", options: ["自動煞車", "主動式車距調節巡航", "車道偏移輔助", "盲點偵測"], correctAnswer: "主動式車距調節巡航"),
        Question(text: "AEB（自動緊急煞車）通常是結合哪些感測器來判斷？", options: ["雷達與攝影機", "胎壓感測器", "溫度感測器", "陀螺儀"], correctAnswer: "雷達與攝影機"),
        Question(text: "LKA（車道維持輔助）主要偵測道路上的什麼？", options: ["前車尾燈", "交通號誌", "標線", "路樹"], correctAnswer: "標線"),
        Question(text: "盲點偵測系統（BSD）最常使用的偵測硬體是？", options: ["長程雷達", "短程超音波或電波雷達", "雷射雷達 (Lidar)", "倒車顯影鏡頭"], correctAnswer: "短程超音波或電波雷達"),
        Question(text: "在自動駕駛分級中，目前市售車主流的「雙手仍需放在方向盤」屬於第幾級？", options: ["Level 1", "Level 2", "Level 4", "Level 5"], correctAnswer: "Level 2"),
        Question(text: "光學雷達（LiDAR）主要是發射什麼來感測環境？", options: ["超音波", "無線電波", "雷射光束", "紅外線"], correctAnswer: "雷射光束"),
        Question(text: "倒車雷達通常使用的是哪種感測技術？", options: ["雷射", "紅外線", "超音波", "毫米波"], correctAnswer: "超音波"),
        Question(text: "HUD（抬頭顯示器）的主要安全性目的為何？", options: ["讓儀表板變好看", "減少駕駛視線離開路面的時間", "顯示導航地圖", "夜視功能"], correctAnswer: "減少駕駛視線離開路面的時間"),
        Question(text: "ABS（防鎖死煞車系統）的主要目的是什麼？", options: ["縮短煞車距離", "保持緊急煞車時的轉向能力", "增加煞車力道", "節省來令片磨耗"], correctAnswer: "保持緊急煞車時的轉向能力"),

        // --- 油電混合系統 (Hybrid System) ---
        Question(text: "豐田 HSD 油電系統中，負責調配引擎與馬達動力輸出的核心元件是？", options: ["行星齒輪動力分配器 (PSD)", "傳統離合器", "液力變矩器", "手排變速箱"], correctAnswer: "行星齒輪動力分配器 (PSD)"),
        Question(text: "油電車常用的「艾金森循環（Atkinson Cycle）」引擎，其主要特性為何？", options: ["低轉速扭力極大", "膨脹比較大，能提升燃油效率", "構造比一般引擎簡單", "完全不需要進氣閥門"], correctAnswer: "膨脹比較大，能提升燃油效率"),
        Question(text: "關於「動能回收系統（Regenerative Braking）」，下列敘述何者正確？", options: ["將電能轉化為熱能", "透過發電機將減速動能轉化為電能", "只在緊急煞車時觸發", "會增加煞車來令片的磨耗"], correctAnswer: "透過發電機將減速動能轉化為電能"),
        Question(text: "插電式油電混合車（PHEV）與一般油電車（HEV）最大的差別在於？", options: ["PHEV 沒有引擎", "PHEV 的電池容量較大且可外部充電", "HEV 只能吃電，不能加油", "PHEV 換檔速度較快"], correctAnswer: "PHEV 的電池容量較大且可外部充電"),
        Question(text: "在油電混合車中，負責將電池的高壓直流電（DC）轉為馬達驅動交流電（AC）的零件是？", options: ["啟動馬達", "動力控制單元 (Inverter/PCU)", "發電機", "點火線圈"], correctAnswer: "動力控制單元 (Inverter/PCU)"),

        // --- CVT 變速箱專題 ---
        Question(text: "傳統鋼帶式 CVT 變速箱主要是透過改變什麼來達成變速？", options: ["齒輪嚙合位置", "主動與從動滑輪的 V 型盤間距", "離合器片的壓力", "液力變矩器的葉片轉速"], correctAnswer: "主動與從動滑輪的 V 型盤間距"),
        Question(text: "CVT 常見的「橡皮筋效應」是指下列哪種現象？", options: ["變速箱鋼帶斷裂", "起步時輪胎打滑", "引擎轉速拉高但車速增加感緩慢", "倒車速度太快"], correctAnswer: "引擎轉速拉高但車速增加感緩慢"),
        Question(text: "豐田（Toyota）的 Direct Shift CVT 加入了「Launch Gear」，其主要目的為何？", options: ["增加尾速", "分擔高速巡航的負荷", "改善起步動力輸出效率並縮小滑輪尺寸", "單純為了減輕變速箱重量"], correctAnswer: "改善起步動力輸出效率並縮小滑輪尺寸"),
        Question(text: "關於 Bosch 類型的鋼帶（Steel Belt）傳動，其動力傳遞主要是靠什麼？", options: ["鋼片的推力 (Pushing force)", "鋼帶的拉力 (Tension)", "齒輪間的摩擦", "電磁感應"], correctAnswer: "鋼片的推力 (Pushing force)"),
        Question(text: "油電混合車上常見的 e-CVT，其內部構造本質上與傳統 CVT 有何不同？", options: ["使用更多組鋼帶", "完全不使用鋼帶，改用行星齒輪組", "使用電子離合器換檔", "動力來源只有馬達"], correctAnswer: "完全不使用鋼帶，改用行星齒輪組")
    ]
}