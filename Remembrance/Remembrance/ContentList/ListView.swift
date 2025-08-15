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

struct EmojiItem: Identifiable {
    var type: String
    var count: Double
    var imageName: String
    var id = UUID()
}

struct MileStoneItem: Identifiable {
    var id = UUID()
    var name: String
    var centimeter: Int
    var meter: String
    var imageName: String
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
        .init(type: "멍때리는", count: 5, imageName: "pepeBlank"),
        .init(type: "슬픈", count: 4, imageName: "pepeCry"),
        .init(type: "분노한", count: 8, imageName: "pepeAngry"),
        .init(type: "당황한", count: 3, imageName: "pepeFlustered"),
        .init(type: "우울한", count: 4, imageName: "pepeGloomy"),
        .init(type: "행복한", count: 4, imageName: "pepeHappy")
    ]
    
    @State private var emojis: [EmojiItem] = [
        .init(type: "멍때리는", count: 5, imageName: "emojiBlank"),
        .init(type: "슬픈", count: 4, imageName: "emojiCry"),
        .init(type: "분노한", count: 8, imageName: "emojiAngry"),
        .init(type: "당황한", count: 3, imageName: "emojiFlustered"),
        .init(type: "우울한", count: 4, imageName: "emojiGloomy"),
        .init(type: "행복한", count: 4, imageName: "emojiHappy")
    ]
    
    @State private var milestones: [MileStoneItem] = [
        .init(name: "", centimeter: 0,meter: "", imageName: "nice"),
        .init(name: "피카츄 2.5마리를\n가로로 눕혀 놓은 길이에요!", centimeter: 500,meter: "5m", imageName: "pika"),
        .init(name: "돼지고기 삼겹살 약 60줄 줄 세운 길이에요!", centimeter: 1000,meter: "10m", imageName: "sam"),
        .init(name: "마포대교만큼의 길이에요!", centimeter: 140000, meter: "1,400m!", imageName: "Mapo"),
        .init(name: "마라톤 완주한 길이에요!", centimeter: 4219500,meter: "42,195m!", imageName: "marathon"),
    ]
    
    
    @State private var showMoreLogs = false   // 더보기 토글
    
    var body: some View {
        VStack{
            // MARK: 상단
            HomeHeaderView()
            // MARK: - 리스트: [섹션]
            List {
                
                // MARK: - 글자수 뷰 섹션
                Section{
                    LogCalenderHeaderView()
                    VStack{
                        LogMeterView(emojis: $emojis,milestones: $milestones)
                    }
                    .padding(.bottom, 28)
                    .frame(maxWidth: .infinity, minHeight: 130)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.clear),
                        
                        alignment: .center
                    )
                }
                .listRowSeparator(.hidden)
                
                
                // MARK: 감정통계 뷰 섹션
                Section {
                    LogStatisticsHeaderView(emojis: $emojis)
                    VStack(alignment: .leading) {
                        LogStatisticsView(emojis: $emojis)
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
        }
    }
}

// MARK: - 거리환산 뷰
struct LogMeterView: View {
    //    @Binding var pepes: [PepeItem]
    @Binding var emojis: [EmojiItem]
    @Binding var milestones: [MileStoneItem]
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                VStack{
                    if milestones[1].centimeter < 1{
                        Text("현재 \(milestones[1].centimeter) cm 입니다!")
                    }else if milestones[1].centimeter < 100 {
                        Text("\(milestones[1].centimeter)cm 를 작성하셨네요!")
                            .font(.body)
                            .padding(.bottom, 6)
                        Text("\(milestones[1].name)")
                            .font(.footnote)
                    }else{
                        Text("\(milestones[1].meter)를 작성하셨네요!")
                            .font(.body)
                            .padding(.bottom, 6)
                        Text("\(milestones[1].name)")
                            .font(.footnote)
                    }
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                Spacer()
                VStack{
                    if milestones[1].centimeter < 1{
                        Image(milestones[1].imageName)
                            .resizable()
                            .scaledToFit()    // 원본 비율 유지해서 맞추기
                            .scaleEffect(0.8) // 50% 크기로 줄임
                    }else if milestones[1].centimeter < 100 {
                        Image(milestones[1].imageName)
                            .resizable()
                            .scaledToFit()    // 원본 비율 유지해서 맞추기
                            .scaleEffect(0.8) // 50% 크기로 줄임
                    }else{
                        Image(milestones[1].imageName)
                            .resizable()
                            .scaledToFit()    // 원본 비율 유지해서 맞추기
                            .scaleEffect(0.8) // 50% 크기로 줄임
                        
                    }
                }.frame(maxHeight: .infinity, alignment: .bottomTrailing)
            }
        }.background(Color(.systemGray5))
            .cornerRadius(12)
    }
}


// MARK: - 그래프 뷰
struct LogStatisticsView: View {
    //    @Binding var pepes: [PepeItem]
    @Binding var emojis: [EmojiItem]
    
    var body: some View {
        VStack (alignment: .leading){
            
            Chart(emojis) {emoji in
                PointMark(
                    x: .value("Shape Type", emoji.type),
                    y: .value("Total Count", emoji.count)
                )
                .symbol {
                    Image(emoji.imageName) // 막대 아래에 이미지 넣기
                    //이미지 크기설정
                        .resizable()
                        .scaledToFit()    // 원본 비율 유지해서 맞추기
                        .scaleEffect(0.07) // 50% 크기로 줄임
                }
            }.chartXAxis(.hidden)
            //                .padding(.top, 8)
            
        }
    }
}

// MARK: - 로그 뷰

struct LogListSectionView: View {
    @Binding var showMoreLogs: Bool
    @Query private var logModel: [LogModel]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        if logModel.isEmpty {
            Text("아직 기록이 없네요!")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.secondary)
                .frame(alignment: .center)
                .listRowSeparator(.hidden)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding([.top,.bottom], 28)
            
            
        } else {
            let moreLogsShow = showMoreLogs ? logModel : Array(logModel.prefix(3))
            ForEach(moreLogsShow) { log in
                VStack{
                    LogListView(logModel: log)
                        .listStyle(.plain)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button {
                                modelContext.delete(log)
                            } label: {
                                Text("삭제")
                            }
                            .tint(.red)
                        }
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



// MARK: - 섹션별 헤더 뷰

struct HomeHeaderView: View{
    @State var selectedMonth = ""
    let months = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
    
    var body: some View{
        VStack{
            Spacer()
            HStack(alignment: .center){
                
                Menu {
                    ForEach(months, id: \.self) { m in
                        Button(m) { selectedMonth = m }
                    }
                } label: {
                    HStack(spacing: 14) {
                        Text(selectedMonth.isEmpty ? months[7] : selectedMonth)
                            .font(.largeTitle)
                        Image(systemName: "chevron.down").font(.title3)
                    }
                    .padding(.horizontal, 10).padding(.vertical, 6)
//                    .background(Color(.systemGray5))
//                    .cornerRadius(12)
                }
                .tint(.primary)
                .menuIndicator(.hidden)
       
                    
                    Spacer()
                    
                    Image(systemName: "gearshape")
                        .font(.title3)
                }
                Spacer()
                
            }.fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 20)
                .padding(.bottom, 8)
            
        }
    }
    
    struct LogCalenderHeaderView: View{
        
        var body: some View{
            VStack(alignment: .leading){
                Spacer()
                HStack{
                    Text("글자가 1cm 라면?")
                        .font(.title2).fontWeight(.semibold)
                        .foregroundColor(.black)
                }
            }
            
            //        }.padding(.bottom, 16)
        }
    }
    
    
    struct LogStatisticsHeaderView: View{
        @Binding var emojis: [EmojiItem]
        
        var body: some View{
            VStack(alignment: .leading){
                Text("이번달은 \(emojis[2].type) 기억이 많네요")
                    .font(.title2).fontWeight(.semibold)
                    .foregroundColor(.black)
            }
        }
    }
    
    struct LogListHeaderView: View {
        @Binding var showMoreLogs: Bool
        @Query private var logModel: [LogModel]
        var body: some View {
            VStack{
                Spacer()
                HStack{
                    Text("기록")
                        .font(.title).fontWeight(.bold)
                    Spacer()
                    //                Image(systemName: "square.and.pencil")
                    //                    .font(.title)
                    if logModel.count > 3 {
                        
                        
                        Button(showMoreLogs ? "접기" : "더보기"){
                            withAnimation(.easeInOut) { showMoreLogs.toggle() }
                            
                        }
                        .font(.callout)
                        .buttonStyle(.plain)
                        .opacity(0.6)
                        
                    }
                }
                Spacer()
                    .foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 20)
            }
        }
    }
    
    
    #Preview {
        ListView()
    }
    
