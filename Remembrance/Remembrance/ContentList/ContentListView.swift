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
  @State private var selectedDate: Date = Date()
  @Query private var logModel: [LogModel]
  
  private var monthLogs: [LogModel] {
    let cal = Calendar.current
    let start = cal.date(from: cal.dateComponents([.year, .month], from: selectedDate))!
    let next  = cal.date(byAdding: .month, value: 1, to: start)!
    return logModel
      .filter { $0.date >= start && $0.date < next }
      .sorted { $0.date > $1.date }
  }
  
  @Environment(\.modelContext) private var modelContext
  
  @State private var milestones: [MilestoneItem] = [
    .init(name: "첫 걸음을 내디뎠어요!", centimeter: 0, meter: "", imageName: "milestonestart"),
    .init(name: "학교 운동장을 한 바퀴 돌 만큼 기록했어요!", centimeter: 400, meter: "400m", imageName: "milestonetrack"),
    .init(name: "작은 산 하나를 올랐어요!", centimeter: 2000, meter: "2km", imageName: "milestonemountain"),
    .init(name: "한강을 끝까지 달렸어요!", centimeter: 25000, meter: "25km", imageName: "milestonehangang"),
    .init(name: "제주도를 횡단한 거리예요! 놀라워요!", centimeter: 42195, meter: "42.195km", imageName: "milestonejeju"),
  ]
  
  var body: some View {
    List {
      // MARK: - 마일스톤
      LogMilestoneHeaderView()
        .padding(.bottom, 4)
        .listRowSeparator(.hidden)
      
      LogMilestoneSectionView(milestones: $milestones)
        .padding(.bottom, 15)
      
      // MARK: - 감정통계
      LogEmotionChartHeaderView(selectedDate: selectedDate)
        .padding(.bottom, 4)
        .listRowSeparator(.hidden)
      
      LogEmotionChartView(selectedDate: selectedDate)
        .padding(.bottom, 20)
      
      // MARK: - 로그
      LogListHeaderView()
        .padding(.vertical, 8)
        .listRowSeparator(.hidden)
      
      LogListSectionView(logs: monthLogs)
        .foregroundColor(.primary)
        .padding(.leading, 15)
        .padding(.trailing, 15)
    }
    .listStyle(.plain)
    //색 전체적으로 넣고싶으면 스크롤콘텐트배경 활성화 하고 색넣으면 됨
    .scrollContentBackground(.hidden)
    .listSectionSpacing(0)
    .safeAreaInset(edge: .top) {
      ContentHeaderView(selectedDate: $selectedDate)
        .background(.ultraThinMaterial)
        .overlay(Divider(), alignment: .bottom)
    }
  }
}



#Preview {
  ContentListView()
}
