//
//  ListViewHeaderView.swift
//  Remembrance
//
//  Created by 엄정민 on 8/17/25.
//
import SwiftUI
import SwiftData

//struct ContentHeaderView: View{
//    @State private var selectedYear: String
//    @State private var selectedMonth: String
//    
//    init() {
//        let today = Date()
//        let calendar = Calendar.current
//        _selectedYear = State(initialValue: String(calendar.component(.year, from: today)))
//        _selectedMonth = State(initialValue: String(calendar.component(.month, from: today)))
//    }

struct ContentHeaderView: View {
    @Binding var selectedDate: Date
    @State private var selectedYear: String
    @State private var selectedMonth: String

    init(selectedDate: Binding<Date>) {
        self._selectedDate = selectedDate
        let d = selectedDate.wrappedValue
        let cal = Calendar.current
        _selectedYear  = State(initialValue: String(cal.component(.year,  from: d)))
        _selectedMonth = State(initialValue: String(cal.component(.month, from: d)))
    }

    private func applySelectionToDate() {
        var comps = DateComponents()
        comps.year = Int(selectedYear)
        comps.month = Int(selectedMonth)
        comps.day = 1
        if let newDate = Calendar.current.date(from: comps) {
            selectedDate = newDate
        }
    }
    
    @State private var showPopover = false
    @Query private var emojis: [EmojiItem]
    @Environment(\.modelContext) private var modelContext
    @State private var showNewLogView = false
    @State private var showSettingView: Bool = false
    
    var body: some View {
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
            
            
            Button { showSettingView.toggle() } label: {
                Image(systemName: "gearshape")
                    .font(.title3)
            }
            .padding(.leading, 8)
            .foregroundColor(.primary)
            
            
            
            Button { showNewLogView = true } label: {
                Image(systemName: "pencil.line")
                    .font(.title3)
            }
            .padding(.leading, 8)
            .foregroundColor(.primary)
            
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        
        .fullScreenCover(isPresented: $showNewLogView) {
            NewLogView()
        }
        .sheet(isPresented: $showSettingView, content: {
            SettingView()
                .presentationDetents([.height(500)])
                .presentationBackground(Color.clear)
        })
        // 연/월 값이 바뀌면 selectedDate 갱신
        .onChange(of: selectedYear) { _, _ in applySelectionToDate() }
        .onChange(of: selectedMonth) { _, _ in applySelectionToDate() }
    }
}
