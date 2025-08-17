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
        NavigationLink(destination: ListDetailView(logModel: logModel)) {
            Text("\(logModel.date, formatter: dateFormatter)")
                .foregroundColor(.primary)
            //                    .padding(.horizontal, 24)
        }
        
    }
}
