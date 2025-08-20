//
//  LogRowView.swift
//  Remembrance
//
//  Created by 엄정민 on 8/17/25.
//
import SwiftUI
import SwiftData

struct LogRowView: View {
    let logModel: LogModel
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var body: some View {
        NavigationLink(destination: LogListDetailView(logModel: logModel)) {
            HStack {
                Text("\(logModel.title)")
                    .font(.system(size: 18, weight: .medium))
                
                Spacer()
                
                Text("\(logModel.date, formatter: dateFormatter)")
                    .font(.system(size: 12))
                    .foregroundColor(.primary)
            }
        }
    }
}
