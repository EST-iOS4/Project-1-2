//
//  ListView.swift
//  Remembrance
//
//  Created by JeongminEom on 8/11/25.
//

import SwiftUI
import SwiftData
import Charts


struct LogItem: Identifiable {
    var id = UUID()
    var title: String
}

struct PepeItem: Identifiable {
    var type: String
    var count: Double
    var imageName: String
    var id = UUID()
    
}

struct ListView: View {
    @Query private var logModel: [LogModel]
    @Environment(\.modelContext) private var modelContext
    //    @State private var logs: [LogItem] = [
    //        LogItem(title: "8월 1일 회고"),
    //        LogItem(title: "8월 2일 회고"),
    //        LogItem(title: "8월 3일 회고"),
    //        LogItem(title: "8월 4일 회고"),
    //        LogItem(title: "8월 5일 회고")
    //    ]
    
    @State private var pepes: [PepeItem] = [
        PepeItem(type: "허탈", count: 5, imageName: "pepeBlank"),
        PepeItem(type: "슬픔", count: 4, imageName: "pepeCry"),
        PepeItem(type: "분노", count: 8, imageName: "pepeFist"),
        PepeItem(type: "당황", count: 3, imageName: "pepeFlustered"),
        PepeItem(type: "우울", count: 4, imageName: "pepeGloomy"),
        PepeItem(type: "행복", count: 4, imageName: "pepeHappy")
    ]
    
    var body: some View {
        VStack{
            //버튼을 picker로 변경하면됨
            Button{}
            label: {
                HStack(spacing: 14){
                    Text("8월")
                        .lineLimit(1)
                        .font(.largeTitle)
                    Image(systemName: "chevron.down")
                }.padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.black, lineWidth: 0.5)
                    )
            }
            .buttonStyle(.plain) // 기본 파란색하고 하이라이트 제거
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 28)
            List {
                // 캘린더와 통계
                Section {
                    VStack(alignment: .leading, spacing: 16) {
                        //나의회고 log는 깃헙 잔디 스타일로 수평 스크롤로 구현하기 (단위는 1년 단위)
                        Text("이만큼 기록했어요!")
                            .font(.title3).fontWeight(.semibold)
                        LogCalenderView(pepes: $pepes)
                    }
                }
                .padding(.bottom, 28)
                .listRowSeparator(.hidden)
                
                Section {
                    VStack(alignment: .leading, spacing: 16) {
                        //페페 Log는 전체 페페 데이터를 계산해서 퍼센테이지 등으로 나타내주기
                        Text("감정 통계")
                            .font(.title3).fontWeight(.semibold)
                        LogStatisticsView(pepes: $pepes)
                    }
                }
                .padding(.bottom, 28)
                .listRowSeparator(.hidden)
                
                
                Section {
                    Text("기록")
                        .font(.title3).fontWeight(.semibold)
                    if logModel.isEmpty {
                        Text("아직 기록이 없네요!")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.secondary)
                            .frame(alignment: .center)
                            .listRowSeparator(.hidden)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 24)
                        
                    } else {
                        ForEach(logModel) { log in
                            LogListView(logModel: log)
                                .padding(.horizontal, 20)
                                .listStyle(.plain)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button {
                                        modelContext.delete(log)
                                    } label: {
                                        // MARK: - 삭제시 삭제 버튼 자연스럽게 만들기
                                        Text("삭제")
                                    }
                                    .tint(.red)
                                }
                        }
                    }
                }
                
                
            }
            .listStyle(.plain)
            .listSectionSpacing(8)  //Section사이의 거리
        }
    }
}
struct LogCalenderView: View {
    @Binding var pepes: [PepeItem]
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            // MARK: - TODO: 피그마로 글자수 -> 거리환산 폼으로 만들어보기 8/14
            RoundedRectangle(cornerRadius: 12.0)
                .stroke(lineWidth: 1)
                .frame(height: 160)
                .overlay(alignment: .center){
                    Grid {
                        GridRow {
                            ForEach(0..<12) { _ in Rectangle()
                                .frame(width: 20, height: 20) }
                        }
                        GridRow {
                            ForEach(0..<12) { _ in Rectangle()
                                .frame(width: 20, height: 20) }
                        }
                        GridRow {
                            ForEach(0..<12) { _ in Rectangle()
                                .frame(width: 20, height: 20) }
                        }
                        GridRow {
                            ForEach(0..<12) { _ in Rectangle()
                                .frame(width: 20, height: 20) }
                        }
                        GridRow {
                            ForEach(0..<12) { _ in Rectangle()
                                .frame(width: 20, height: 20) }
                        }
                    }
                }
        }
    }
}



struct LogStatisticsView: View {
    @Binding var pepes: [PepeItem]
    
    var body: some View {
        VStack (alignment: .leading, spacing: 8){
            
            Chart(pepes) {pepe in
                PointMark(
                    x: .value("Shape Type", pepe.type),
                    y: .value("Total Count", pepe.count)
                )
                .symbol {
                    Image(pepe.imageName) // 막대 아래에 이미지 넣기
                    //이미지 크기설정
                        .resizable()
                        .scaledToFit()    // 원본 비율 유지해서 맞추기
                        .scaleEffect(0.1) // 50% 크기로 줄임
                }
            }
            
        }
    }
}

struct LogListView: View {
    let logModel: LogModel
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var body: some View {
        NavigationLink(destination: ListDetailView(logModel: logModel)) {
            Text("\(logModel.date, formatter: dateFormatter)")
                .foregroundColor(.primary)
            //                    .padding(.horizontal, 24)
        }
        
    }
}

#Preview {
    ListView()
}

