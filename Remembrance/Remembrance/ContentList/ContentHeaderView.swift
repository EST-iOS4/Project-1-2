//
//  ListViewHeaderView.swift
//  Remembrance
//
//  Created by 엄정민 on 8/17/25.
//
import SwiftUI
import SwiftData

struct ContentHeaderView: View{
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
}
