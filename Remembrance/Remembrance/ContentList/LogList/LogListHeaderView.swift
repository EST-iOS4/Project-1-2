//
//  Untitled.swift
//  Remembrance
//
//  Created by 엄정민 on 8/17/25.
//

import SwiftUI
import SwiftData

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
