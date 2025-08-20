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
  @State private var deleteID: UUID? = nil
  
  let logs: [LogModel]
  @Environment(\.modelContext) private var modelContext
  
  var body: some View {
    if logs.isEmpty {
      Text("아직 기록이 없네요!")
        .font(.body)
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity, minHeight: 250)
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .listRowSeparator(.hidden)
    } else {
      // 필요 시 더보기 로직
      ForEach(logs) { log in
        
        LogRowView(logModel: log)
          .listStyle(.plain)
//          .listRowInsets(EdgeInsets())
          .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button {
              deleteID = log.id
              showAlert = true
            } label: {
              Text("삭제")
            }
            .tint(.red)
          }
        
      }
      .alert("정말로 삭제하시겠습니까?", isPresented: $showAlert) {
        Button(role: .destructive) {
          if let id = deleteID, let idx = logs.firstIndex(where: { $0.id == id }) {
            modelContext.delete(logs[idx])
          }
          deleteID = nil
        } label: {
          Text("삭제")
        }
        Button("취소", role: .cancel) {
          deleteID = nil
        }
      }
    }
  }
}
