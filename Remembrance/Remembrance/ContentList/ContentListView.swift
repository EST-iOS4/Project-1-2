//
//  ListView.swift
//  Remembrance
//
//  Created by JeongminEom on 8/11/25.
//

import SwiftUI
import SwiftData
import Charts


struct PepeItem: Identifiable {
    var type: String
    var count: Double
    var imageName: String
    var id = UUID()
}



struct MilestoneItem: Identifiable {
    var id = UUID()
    var name: String
    var centimeter: Int
    var meter: String
    var imageName: String
}


struct ContentListView: View {
    @Query private var logModel: [LogModel]
    @Query private var emojis: [EmojiItem]
    @Environment(\.modelContext) private var modelContext
    
    //    @State private var logs: [LogItem] = [
    //        LogItem(title: "8월 1일 회고"),
    //        LogItem(title: "8월 2일 회고"),
    //        LogItem(title: "8월 3일 회고"),
    //        LogItem(title: "8월 4일 회고"),
    //        LogItem(title: "8월 5일 회고")
    //    ]
    
    @State private var pepes: [PepeItem] = [
        .init(type: "멍때리는", count: 5, imageName: "pepeBlank"),
        .init(type: "슬픈", count: 4, imageName: "pepeCry"),
        .init(type: "분노한", count: 8, imageName: "pepeAngry"),
        .init(type: "당황한", count: 3, imageName: "pepeFlustered"),
        .init(type: "우울한", count: 4, imageName: "pepeGloomy"),
        .init(type: "행복한", count: 4, imageName: "pepeHappy")
    ]
    
    
    
    @State private var milestones: [MilestoneItem] = [
        .init(name: "", centimeter: 0,meter: "", imageName: "nice"),
        .init(name: "피카츄 2.5마리를\n가로로 눕혀 놓은 길이에요!", centimeter: 500,meter: "5m", imageName: "pika"),
        .init(name: "돼지고기 삼겹살 약 60줄 줄 세운 길이에요!", centimeter: 1000,meter: "10m", imageName: "sam"),
        .init(name: "마포대교만큼의 길이에요!", centimeter: 140000, meter: "1,400m!", imageName: "Mapo"),
        .init(name: "마라톤 완주한 길이에요!", centimeter: 4219500,meter: "42,195m!", imageName: "marathon"),
    ]
    
    
    @State private var showMoreLogs = false   // 더보기 토글
    
    var body: some View {
        VStack{
            List {
                
                // MARK: - 마일스톤 뷰 섹션
                Section{
                    LogMilestoneHeaderView()
                    VStack{
                        LogMilestoneSectionView(milestones: $milestones)
                    }
                    .padding(.bottom, 28)
                    .frame(maxWidth: .infinity, minHeight: 130)
                }
                .listRowSeparator(.hidden)
                
                
                // MARK: 감정통계 뷰 섹션
                Section {
                    VStack{
                        LogChartHeaderView()
                    }
                    VStack(alignment: .leading) {
                        LogChartView()
                    }
                    .padding(.bottom, 20)
                    .listRowSeparator(.hidden)
                    .frame(height: 120)
                }
                
                
                
                // MARK: - 로그 뷰 섹션
                Section {
                    VStack{
                        LogListHeaderView(showMoreLogs: $showMoreLogs)
                    }
                    LogListSectionView(showMoreLogs: $showMoreLogs)
                }
            }
            .listStyle(.plain)
            .safeAreaInset(edge: .top) {
                ContentHeaderView()
                    .background(.ultraThinMaterial)
                    .overlay(Divider(), alignment: .bottom)
            }
        }
    }
}



#Preview {
    ContentListView()
}
