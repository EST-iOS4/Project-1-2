//
//  ListView.swift
//  Remembrance
//
//  Created by JeongminEom on 8/11/25.
//

import SwiftUI

struct LogItem: Identifiable {
  var id = UUID()
  var title: String
}

struct ListView: View {
  @State private var Logs: [LogItem] = [
    LogItem(title: "8월 1일 회고"),
    LogItem(title: "8월 2일 회고"),
    LogItem(title: "8월 3일 회고"),
    LogItem(title: "8월 4일 회고"),
    LogItem(title: "8월 5일 회고")
  ]
  
  
  var body: some View {
    List {
      // 캘린더와 통계
      Section {
        VStack(alignment: .leading, spacing: 12) {
          Text("나의 회고 Log")
          LogCalenderView()
        }
      }
      .listRowSeparator(.hidden)
      
      
      Section {
        VStack(alignment: .leading, spacing: 12) {
          Text("최고 작성률 Log")
          LogStatisticsView()
        }
      }
      .listRowSeparator(.hidden)
      
      
      Section {
        Text("Log")
        ForEach($Logs) { $log in
          LogListView(log: $log)
          
        }
      }
      .listRowInsets(.init(top: 0, leading: 16, bottom: 12, trailing: 16))
      .listRowSeparator(.hidden)
      
      
    }.listStyle(.plain)
      .listSectionSpacing(8)  //Section사이의 거리
  }
}

struct LogCalenderView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      
      RoundedRectangle(cornerRadius: 12.0)
        .stroke(.black, lineWidth: 1)
        .frame(height: 160)
        .overlay(alignment: .center){
          Text("더미 회고 로그")
        }
    }
  }
}


struct LogStatisticsView: View {
  var body: some View {
    VStack (alignment: .leading, spacing: 8){
      
      RoundedRectangle(cornerRadius: 12.0)
        .stroke(.black, lineWidth: 1)
        .frame(height: 160)
        .overlay(alignment: .center){
          Text("아직 기록이 없네요!\n기록해보세요")
        }
    }
  }
}

struct LogListView: View {
  @Binding var log: LogItem
  
  var body: some View {
    RoundedRectangle(cornerRadius: 10)
      .stroke(lineWidth: 1)             //윤곽선
      .frame(height: 60)                //크기
      .overlay(alignment: .leading){    //내부 글자
        Text(log.title)
          .foregroundColor(.primary)
          .padding(.leading, 24)        // 박스 안쪽 여백
      }.background(
        NavigationLink("이동", destination: ListDetailView())
          .opacity(0)
          .frame(height: 60)
      )
  }
}


#Preview {
  ListView()
}

