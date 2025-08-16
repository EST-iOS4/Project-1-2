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



struct MileStoneItem: Identifiable {
    var id = UUID()
    var name: String
    var centimeter: Int
    var meter: String
    var imageName: String
}


struct ListView: View {
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
            // MARK: Body
            // MARK: - 리스트: [섹션]
            List {
                
                // MARK: - 글자수 뷰 섹션
                Section{
                    LogCalenderHeaderView()
                    VStack{
                        LogMeterView(milestones: $milestones)
                    }
                    .padding(.bottom, 28)
                    .frame(maxWidth: .infinity, minHeight: 130)
                }
                .listRowSeparator(.hidden)
                
                
                // MARK: 감정통계 뷰 섹션
                Section {
                    VStack{
                        LogStatisticsHeaderView()
                    }
                    VStack(alignment: .leading) {
                        LogStatisticsView()
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
                HomeHeaderView()
                    .background(.ultraThinMaterial)
                    .overlay(Divider(), alignment: .bottom)
            }
        }
    }
}

// MARK: - 거리환산 뷰
struct LogMeterView: View {
    //    @Binding var pepes: [PepeItem]
    @Binding var milestones: [MileStoneItem]
    @Query private var emojis: [EmojiItem]
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
                            .scaledToFit()
                            .scaleEffect(0.8)
                    }else if milestones[1].centimeter < 100 {
                        Image(milestones[1].imageName)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(0.8)
                    }else{
                        Image(milestones[1].imageName)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(0.8)
                        
                    }
                }.frame(maxHeight: .infinity, alignment: .bottomTrailing)
            }
        }.background(Color(.systemGray4))
            .cornerRadius(12)
    }
}


// MARK: - 그래프 뷰
struct LogStatisticsView: View {
    //    @Binding var pepes: [PepeItem]
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

// MARK: - 한개의 로그리스트 뷰
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





// MARK: - 메인 헤더
struct HomeHeaderView: View{
    @State private var selectedYear = "2025"
    @State private var selectedMonth = "8"
    @State private var showPopover = false
    @Query private var emojis: [EmojiItem]
    @Environment(\.modelContext) private var modelContext
    @State private var showSave = false
    
    var body: some View{
        
        HStack {
            Button {
                showPopover.toggle()
            } label: {
                HStack(spacing: 6) {
                    Text("\(selectedMonth)월")
                        .font(.largeTitle)
                    
                    Image(systemName: "chevron.down")
                        .font(.title3)
                        .rotationEffect(.degrees(showPopover ? 180 : 0))
                        .animation(.easeInOut(duration: 0.2), value: showPopover)
                }
            }
            .foregroundColor(.primary)
            .fontWeight(.bold)
            .overlay(alignment: .bottomLeading) {
                Color.clear
                    .frame(width: 1, height: 1)
                    .offset(x: 18, y: 36)
                    .popover(isPresented: $showPopover,
                             attachmentAnchor: .rect(.bounds),
                             arrowEdge: .top) {
                        YearMonthPicker(
                            selectedYear: $selectedYear,
                            selectedMonth: $selectedMonth,
                            onDone: { showPopover = false }
                        )
                        .frame(width: 320, height: 220)
                        .presentationCompactAdaptation(.none)
                        .padding(.top, 12)
                    }
            }
            
            Spacer()
            //그래프 테스트
            //            Button {
            //                incrementEmojiCounts()
            //            } label: {
            //                Image(systemName: "plus.circle.fill")
            //                    .font(.title3)
            //            }
            
            
            Image(systemName: "gearshape")
                .font(.title3)
            
            
            
            Button { showSave = true } label: {
                Image(systemName: "pencil.line")
                    .font(.title3)
            }
            .padding(.leading, 8)
            .foregroundColor(.primary)
            
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        
        .sheet(isPresented: $showSave) {
            SaveView()
        }
        
        
    }
    //그래프 테스트
    //    private func incrementEmojiCounts() {
    //        for emoji in emojis {
    //            emoji.count += 1
    //        }
    //        try? modelContext.save()
    //    }
}
// MARK: - 월피커
struct YearMonthPicker: View {
    @Binding var selectedYear: String
    @Binding var selectedMonth: String
    var onDone: (() -> Void)? = nil
    
    let years = (2000...2035).map { String($0) }
    let months = (1...12).map { String($0) }
    @State private var show = false
    
    var body: some View {
        VStack(spacing: 12) {
            
            HStack{
                Text("연/월 선택")
                    .font(.headline)
                Spacer()
                Button("완료") { onDone?() }
                    .buttonStyle(.automatic)
            }
            
            
            
            HStack {
                Picker("Year", selection: $selectedYear) {
                    ForEach(years, id: \.self) { year in
                        Text("\(year)년")
                            .tag(year)
                    }
                }
                .pickerStyle(.wheel)
                
                Picker("Month", selection: $selectedMonth) {
                    ForEach(months, id: \.self) { Text("\($0)월").tag($0) }
                }
                .pickerStyle(.wheel)
            }
            .frame(height: 180)
            
            
        }
        
        .padding()
        .frame(width: 320) // 팝오버 크기
        .presentationCompactAdaptation(.none) // ← 아이폰에서도 팝오버 유지 (iOS17+)
    }
}
// MARK: - 글자수환산 헤더
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
    }
}

// MARK: - 그래프 헤더
struct LogStatisticsHeaderView: View{
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

// MARK: - 로그리스트 헤더
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
