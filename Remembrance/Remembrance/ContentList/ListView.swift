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
            HStack{
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
                
                Spacer()
                Image(systemName: "gearshape")
                    .font(.title3)
                    .padding(.trailing, 20)

                
            }
            List {
                //회고기록
                Section(header: LogListHeaderView(showMoreLogs: $showMoreLogs)) {
//                    HStack{
//                        Text("기록")
//                            .font(.title3).fontWeight(.semibold)
//                            .frame(alignment: .leading)
//                        Spacer()
//
//                        Button(showMoreLogs ? "접기" : "더보기"){
//                            withAnimation(.easeInOut) { showMoreLogs.toggle() }
//                        }
//                        .font(.callout).fontWeight(.semibold)
//                        .buttonStyle(.plain)
//                        Image(systemName: "square.and.pencil")
//                            .font(.title)
//                    }.frame(maxHeight: .infinity, alignment: .center)
//                        .padding(.bottom, 28)
                    
                    if logModel.isEmpty {
                        Text("아직 기록이 없네요!")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.secondary)
                            .frame(alignment: .center)
                            .listRowSeparator(.hidden)
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                        
                    } else {
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                                Button(showMoreLogs ? "접기" : "더보기"){
                                    withAnimation(.easeInOut) { showMoreLogs.toggle() }
                                }
                                .font(.callout).fontWeight(.semibold)
                                .buttonStyle(.plain)
                                .frame(width: 50, alignment: .center)
                            }
                        }
                        .listRowSeparator(.hidden)
                        
                        let moreLogsShow = showMoreLogs ? logModel : Array(logModel.prefix(3))
                        ForEach(moreLogsShow) { log in
                            LogListView(logModel: log)
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
                
                // MARK: - 글자수 거리
                Section(header:LogCalenderHeaderView()){
                    VStack{
                        //나의회고 log는 깃헙 잔디 스타일로 수평 스크롤로 구현하기 (단위는 1년 단위)
                        LogCalenderView(emojis: $emojis,milestones: $milestones)
                    }
                    .frame(maxWidth: .infinity, minHeight: 130)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.clear),
                    
                        alignment: .center
                    )
                }
                .listRowSeparator(.hidden)
                
                
                
                
                
                
                //감정통계
                Section(header: LogStatisticsHeaderView(emojis: $emojis)) {
                    
                    VStack(alignment: .leading) {
                        //페페 Log는 전체 페페 데이터를 계산해서 퍼센테이지 등으로 나타내주기
                        LogStatisticsView(emojis: $emojis)
                    }
                    .listRowSeparator(.hidden)
                    .frame(height: 120)
                }
                
                
                
//                //회고기록
//                Section(header: LogListHeaderView(showMoreLogs: $showMoreLogs)) {
////                    HStack{
////                        Text("기록")
////                            .font(.title3).fontWeight(.semibold)
////                            .frame(alignment: .leading)
////                        Spacer()
////                        
////                        Button(showMoreLogs ? "접기" : "더보기"){
////                            withAnimation(.easeInOut) { showMoreLogs.toggle() }
////                        }
////                        .font(.callout).fontWeight(.semibold)
////                        .buttonStyle(.plain)
////                        Image(systemName: "square.and.pencil")
////                            .font(.title)
////                    }.frame(maxHeight: .infinity, alignment: .center)
////                        .padding(.bottom, 28)
//                    
//                    if logModel.isEmpty {
//                        Text("아직 기록이 없네요!")
//                            .font(.system(size: 16, weight: .semibold))
//                            .foregroundStyle(.secondary)
//                            .frame(alignment: .center)
//                            .listRowSeparator(.hidden)
//                            .frame(maxWidth: .infinity, alignment: .center)
//                            
//                        
//                    } else {
//                        VStack{
//                            Spacer()
//                            HStack{
//                                Spacer()
//                                Button(showMoreLogs ? "접기" : "더보기"){
//                                    withAnimation(.easeInOut) { showMoreLogs.toggle() }
//                                }
//                                .font(.callout).fontWeight(.semibold)
//                                .buttonStyle(.plain)
//                                .frame(width: 50, alignment: .center)
//                            }
//                        }
//                        .listRowSeparator(.hidden)
//                        
//                        let moreLogsShow = showMoreLogs ? logModel : Array(logModel.prefix(3))
//                        ForEach(moreLogsShow) { log in
//                            LogListView(logModel: log)
//                                .listStyle(.plain)
//                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
//                                    Button {
//                                        modelContext.delete(log)
//                                    } label: {
//                                        // MARK: - 삭제시 삭제 버튼 자연스럽게 만들기
//                                        Text("삭제")
//                                    }
//                                    .tint(.red)
//                                }
//                        }
//                    }
//                }
                
                
            }
            .listStyle(.plain)
        }
    }
}


// MARK: - 거리환산 뷰 [섹션]

struct LogCalenderView: View {
//    @Binding var pepes: [PepeItem]
    @Binding var emojis: [EmojiItem]
    @Binding var milestones: [MileStoneItem]
    var body: some View {
        VStack(alignment: .leading) {
            
            // MARK: - 피그마로 글자수 -> 거리환산 폼으로 만들어보기 8/14
            HStack{
                VStack{
                    if milestones[1].centimeter < 1{
                        Text("현재 \(milestones[1].centimeter) cm 입니다!")
                    }else if milestones[1].centimeter < 100 {
                        Text("\(milestones[1].centimeter)cm 를 달성하셨네요!")
                            .font(.body)
                            .padding(.bottom, 6)
                        Text("\(milestones[1].name)")
                            .font(.footnote)
                    }else{
                        Text("\(milestones[1].meter)를 달성하셨네요!")
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


// MARK: - 그래프 뷰 [섹션]
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
                .padding(.top, 8)
            
        }
    }
}

// MARK: - 로그 뷰 [섹션]
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

struct LogCalenderHeaderView: View{
    
    var body: some View{
        VStack(alignment: .leading){
            Text("글자가 1cm 라면?")
                .font(.title2).fontWeight(.semibold)
                .foregroundColor(.black)
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
        }.padding(.bottom, 28)
    }
}

struct LogListHeaderView: View {
    @Binding var showMoreLogs: Bool
    
    var body: some View {
        VStack(alignment: .center){
            HStack{
                Text("기록")
                    .font(.title).fontWeight(.semibold)
                Spacer()
                Image(systemName: "square.and.pencil")
                    .font(.title2)
            }
            .foregroundColor(.black)
        }.padding(.bottom, 12)
    }
}


#Preview {
    ListView()
}

