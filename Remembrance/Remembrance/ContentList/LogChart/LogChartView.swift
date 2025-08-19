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
  
  private struct EmojiBar: Identifiable {
    
    let id = UUID()
    let emotionType: emotionType
    let count: Int
    var emotionName: String { emotionType.emotionString }
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
    print("Debug logs:\(logs)")
    let monthLogs = logs.filter {
      $0.date >= startOfMonth && $0.date < startOfNextMonth && !$0.emoji.isEmpty
    }
    print("Debug monthLogs:\(monthLogs)")
  
    // 모든 이모지를 0 포함해 고정 순서로 만듦
    return emotionType.allCases.map { e in
      let c = monthLogs.filter { $0.emoji == e.emotionString }.count // 이모티콘 개수
      print("Debug EmojiBar: emotionType \(e), count \(c)")
      return EmojiBar(emotionType: e, count: c)
    }
  }
  
  var body: some View {
    let b = bars   // ← 여기서 1번만 계산

    VStack(alignment: .leading) {
      if b.allSatisfy({ $0.count == 0 }) {
        Text("이 달의 데이터가 없어요. 기록을 추가해 보세요.")
          .foregroundStyle(.secondary)
          .frame(maxWidth: .infinity, minHeight: 160)
      } else {
        Chart(b) { item in
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
          AxisMarks(values: b.map { "\(themeManager.currentTheme)\($0.emotionName)" }) { v in
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
