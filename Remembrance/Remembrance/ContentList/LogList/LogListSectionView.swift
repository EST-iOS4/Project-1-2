//
//  LogListView.swift
//  Remembrance
//
//  Created by 엄정민 on 8/17/25.
//
import SwiftUI
import SwiftData

struct LogListSectionView: View {
    @State private var showAlert: Bool = false
    
    let logs: [LogModel]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        if logs.isEmpty {
            Text("아직 기록이 없네요!")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.secondary)
                .frame(alignment: .center)
                .listRowSeparator(.hidden)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding([.top,.bottom], 28)
        } else {
            // 필요 시 더보기 로직
            ForEach(logs) { log in
                VStack {
                    LogRowView(logModel: log)
                        .listStyle(.plain)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button {
                                showAlert = true
                            } label: {
                                Text("삭제")
                            }
                            .tint(.red)
                        }
                        .alert("정말로 삭제하시겠습니까?", isPresented: $showAlert) {
                            Button(role: .destructive) {
                                modelContext.delete(log)
                            } label: {
                                Text("삭제")
                            }
                        }
                }
            }
        }
    }
}
