//
//  LogListDetailView.swift
//  Remembrance
//
//  Created by JaeyoungLee on 8/11/25.
//
import SwiftUI
import SwiftData

struct LogListDetailView: View {
  @Environment(\.modelContext) private var modelContext
  @EnvironmentObject var themeManager : ThemeManager
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
            .font(.title)
            .fontWeight(.bold)
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
              Image("\(themeManager.currentTheme)\(logModel.emoji)")
                .resizable()
                .frame(width: 100, height: 100)
                .scaledToFill()
                .clipShape(Circle())
            }
          }
        
          .padding(.bottom, 28)
        
        VStack(alignment: .leading) {
          HStack {
            Text("내용")
              .font(.title3).fontWeight(.semibold)
            Spacer()
            
            Text("#\(logModel.tag)")
              .font(.caption)
          }
          RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(Color.gray.opacity(0.3))
            .overlay(alignment: .topLeading) {
              Text("\(logModel.content)")
                .padding()
                .font(.body)
                .padding(15)
              
              // MARK: - 메모
              // TODO: 내용 TextEditor 200자 제한, 글씨 수 셀 수 있는 로직 추가하기
              // TODO: 프레임을 동적으로 적용할 수 있도록 고려하기 (아이패드도 지원해야 함)
            }
            .frame(maxWidth: .infinity, minHeight: 90)
          
          
        }
      }
      .padding(20)
    }
  }
}

#Preview {
  LogListDetailView(logModel: LogModel(id: UUID(), emoji: ""))
}

