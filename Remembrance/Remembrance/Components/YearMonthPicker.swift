//
//  YearMonthPicker.swift
//  Remembrance
//
//  Created by 엄정민 on 8/17/25.
//
import SwiftUI
import SwiftData

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
