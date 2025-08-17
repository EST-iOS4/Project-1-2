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
    @Query private var emojis: [EmojiItem]
    
    var body: some View {
        let hasAnyCount = emojis.contains { $0.count > 0 }
        if hasAnyCount,
           let top = emojis.max(by: { $0.count < $1.count }),
           top.count > 0 {
            Text("이번달은 \(top.type) 기억이 많네요")
        } else {
            Text("이번달 기분을 기록해볼까요?")
        }
        
    }
}
