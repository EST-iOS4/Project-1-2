//
//  ListDetailView.swift
//  Remembrance
//
//  Created by JaeyoungLee on 8/11/25.
//

import SwiftUI
import SwiftData

struct ListDetailView: View {
    @Environment(\.modelContext) private var modelContext
    //    @Query private var logModel: [LogModel]
    let logModel: LogModel
    
    @State private var text: String = "write something"
    
    let date = Date()
    let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("\(logModel.title)")
//                        .font(.title3)
//                        .fontWeight(.semibold)
                        .font(.system(size: 25, weight: .bold))
                    
                    Spacer()
                    
                    Text("\(logModel.date, formatter: dateFormat)")
                        .font(.body)
                }
                .padding(.bottom, 28)
                
                
                Circle()
                    .stroke(Color.gray, lineWidth: 2)
                    .frame(width: 120, height: 120)
//                    .foregroundStyle(.green)
                    .overlay {
                        VStack {
                            Image(logModel.emoji)
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                    }
                
                    .padding(.bottom, 28)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("내용")
                            .font(.title3).fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text("\(logModel.tag)")
                    }
                    RoundedRectangle(cornerRadius: 20)
                        .overlay(alignment: .topLeading) {
                            Text("\(logModel.content)")
                                .padding()
                                .foregroundStyle(.black)
                                .font(.system(size: 17, weight: .regular))
                            
                            // MARK: - 메모
                            // TODO: 내용 TextEditor 200자 제한, 글씨 수 셀 수 있는 로직 추가하기
                            // TODO: 프레임을 동적으로 적용할 수 있도록 고려하기 (아이패드도 지원해야 함)
                        }
                        .frame(maxWidth: .infinity, minHeight: 90)
                        .foregroundStyle(Color.gray.opacity(0.3))
                    
                }
            }
            .padding(20)
        }
    }
}

#Preview {
    ListDetailView(logModel: LogModel(id: UUID(), emoji: ""))
}
