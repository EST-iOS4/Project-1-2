//
//  LogChartView.swift
//  Remembrance
//
//  Created by 엄정민 on 8/17/25.
//

import Charts
import SwiftData
import SwiftUI

struct LogChartView: View {
  let selectedDate: Date
  @Query private var logs: [LogModel]
  @EnvironmentObject var themeManager : ThemeManager
  // pepeEmoji.allCases 순서대로 막대를 만들기 위해 사용
  
  private struct EmojiBar: Identifiable {
    //        let id = UUID()
    //        let emoji: pepeEmoji
    //        let count: Int
    //        var imageName: String { emoji.pepeImage }
    
    let id = UUID()
    let emotionType: emotionType
    let count: Int
    var emotionName: String { emotionType.emotionString }
    
    //      func imageName(theme: ThemeManager) -> String {
    //             "\(theme.currentTheme)\(emotion.rawValue)"
    //         }
  }
  
  // 해당 월의 시작, 다음 달 시작
  private var startOfMonth: Date {
    Calendar.current.date(
      from: Calendar.current.dateComponents([.year, .month], from: selectedDate)
    )!
  }
  private var startOfNextMonth: Date {
    Calendar.current.date(byAdding: .month, value: 1, to: startOfMonth)!
  }
  
  // 해당 월 로그만 필터링하기 pepeEmoji 순서대로 개수 산출
  private var bars: [EmojiBar] {
    let monthLogs = logs.filter {
      $0.date >= startOfMonth && $0.date < startOfNextMonth && !$0.emoji.isEmpty
    }
    // 이미지이름(String) → enum 매칭
    //        func toEnum(_ name: String) -> pepeEmoji? {
    //            pepeEmoji.allCases.first { $0.pepeImage == name }
    //        }
    // 모든 이모지를 0 포함해 고정 순서로 만듦
    return emotionType.allCases.map { e in
      let c = monthLogs.filter { $0.emoji == e.emotionString }.count // 이모티콘 개수
      return EmojiBar(emotionType: e, count: c)
    }
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      if bars.allSatisfy({ $0.count == 0 }) {
        Text("이 달의 데이터가 없어요. 기록을 추가해 보세요.")
          .foregroundStyle(.secondary)
          .frame(maxWidth: .infinity, minHeight: 160)
      } else {
        Chart(bars) { item in
          BarMark(
            x: .value("Emoji", "\(themeManager.currentTheme)\(item.emotionName)"),
            y: .value("Count", item.count),
            width: .fixed(20)
          )
          .annotation(position: .top) {
            if item.count > 0 {
              Text("\(item.count)").font(.caption2).foregroundStyle(.secondary)
              
            }
          }
        }
        
        .chartXAxis {
          AxisMarks(values: bars.map { "\(themeManager.currentTheme)\($0.emotionName)" }) { v in
            AxisGridLine()
            AxisTick()
            AxisValueLabel {
              if let name = v.as(String.self) {
                Image(name)
                  .resizable()
                  .frame(width: 20, height: 20)
                  .clipShape(RoundedRectangle(cornerRadius: 4))
              }
            }
          }
        }
        .frame(minHeight: 160)
      }
    }
  }
}
