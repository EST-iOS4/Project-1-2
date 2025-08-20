//
//  LogChartHeaderView.swift
//  Remembrance
//
//  Created by 엄정민 on 8/17/25.
//

import SwiftUI
import SwiftData
import Charts

struct LogChartHeaderView: View{
    @Query private var logModel: [LogModel]
    let selectedDate: Date
    
    private struct EmojiType: Identifiable {
        let id = UUID()
        let emotionType: emotionType
        let count: Int
        var emotionName: String { emotionType.emotionString }
    }
    
    private var startOfMonth: Date {
      Calendar.current.date(
        from: Calendar.current.dateComponents([.year, .month], from: selectedDate)
      )!
    }
    
    private var startOfNextMonth: Date {
      Calendar.current.date(byAdding: .month, value: 1, to: startOfMonth)!
    }
    
    private var maxEmojiCount: [EmojiType] {
      let monthLogs = logModel.filter {
        $0.date >= startOfMonth && $0.date < startOfNextMonth && !$0.emoji.isEmpty
      }
      print("Debug monthLogs:\(monthLogs)")
    
      return emotionType.allCases.map { e in
        let c = monthLogs.filter { $0.emoji == e.emotionString }.count // 이모티콘 개수
        print("Debug EmojiBar: emotionType \(e), count \(c)")
        return EmojiType(emotionType: e, count: c)
      }
    }
    
    var body: some View {
        let maxCountEmoji = maxEmojiCount.max(by: { $0.count < $1.count } )
        if let maxCount = maxCountEmoji, maxCount.count > 0 {
            Text("이번달 기분은요 \(maxCount.emotionName)\(maxCount.count)회")
                .font(.title2).fontWeight(.semibold)
        } else {
            Text("이번달 기분을 기록해보세요.")
                .font(.title2).fontWeight(.semibold)
        }
    }
}
