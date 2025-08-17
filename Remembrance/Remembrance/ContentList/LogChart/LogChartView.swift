//
//  LogChartView.swift
//  Remembrance
//
//  Created by 엄정민 on 8/17/25.
//
import SwiftUI
import SwiftData
import Charts

struct LogChartView: View {
    @Query private var emojis: [EmojiItem]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        let hasAnyCount = emojis.contains { $0.count > 0 }
        
        VStack (alignment: .leading){
            if hasAnyCount {
                Chart(emojis) {emoji in
                    PointMark(
                        x: .value("Shape Type", emoji.type),
                        y: .value("Total Count", emoji.count)
                    )
                    .symbol {
                        Image(emoji.imageName)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(0.07)
                    }
                }.chartXAxis(.hidden)
            } else{
                Text("아직 데이터가 없어요. \n오른쪽 상단 버튼으로 기록해보세요.")
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, minHeight: 160)
                    .multilineTextAlignment(.center)
            }
        }
    }
}
