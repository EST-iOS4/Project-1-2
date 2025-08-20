//
//  NewLogView.swift
//  Remembrance
//
//  Created by NaSangJin on 8/12/25.
//


import SwiftUI
import SwiftData

struct NewLogView: View {
  
  @Query private var logModel: [LogModel]
  @Environment(\.modelContext) var modelContext
  @Environment(\.dismiss) var dismiss
  
  @EnvironmentObject var themeManager : ThemeManager
  
  @State private var title: String = ""
  @State private var text: String = ""
  @State private var emotion: String = ""
  @State private var tag: String = ""
  
  @State private var tagSelection: String = ""
  let tagDatas: [String] = ["프로젝트", "학습", "일상", "자기관리", "취미"]
  
  @State private var selectDate: Date = Date()
  
  // 텍스트 에디터 초기 글자
  private let placeholder: String = "기록을 작성해 보세요!"
  
  let date = Date()
  let dateFormat: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }()
  
//  let pepes: [pepeEmoji] = pepeEmoji.allCases
  let emotions: [emotionType] = emotionType.allCases
  
  var body: some View {
    NavigationStack {
      ScrollView {
        // MARK: - 제목 칸
        TextField(" 제목", text: $title).font(.title.weight(.semibold))
          .padding(10)
          .background(Color(UIColor.systemGray6))
          .clipShape(RoundedRectangle(cornerRadius: 15))
          .padding(.bottom, 28)

        // MARK: - 날짜 칸
        HStack {
          Text("날짜").font(.title3).fontWeight(.semibold)
          DatePicker("", selection: $selectDate, displayedComponents: [.date])
            .datePickerStyle(.compact)
            .environment(\.locale, .init(identifier: "ko_KR"))
        }
        .padding(.bottom, 28)
        
        // MARK: - 이모지 선택 칸
        HStack {
          ForEach(emotions, id: \.self) { emo in
            Button {
              emotion = emo.emotionString
            } label: {
              HStack {
                Image("\(themeManager.currentTheme)\(emo.emotionString)")
                  .resizable()
                  .renderingMode(.original)
                  .frame(width: 50, height: 50)
                  .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
              }
//              .background("\(themeManager.currentTheme)\(emo.emotionString)" == emotion ? Color.pink.opacity(0.9) : Color.gray.opacity(0.4))
              .background(emotion == emo.emotionString ? Color.pink.opacity(0.8) : Color.gray.opacity(0.4))
              .clipShape(RoundedRectangle(cornerRadius: 10))
            }
          }
        }
        .padding(.bottom, 28)
        
        // MARK: - 내용 기록 칸
        VStack(alignment: .leading, spacing: 16) {
          HStack {
            Text("내용")
              .font(.title3).fontWeight(.semibold)
            
            Spacer()
            
            // MARK: - 태그 선택 구현 완료
            Picker("태그 선택", selection: $tagSelection) {
              Text("태그 선택").tag("")
              ForEach(tagDatas, id: \.self) { tag in
                Text(tag)
              }
            }
            .pickerStyle(.menu)
          }
          
          
          TextEditor(text: $text).customTextEditor(placeholder: placeholder, userInput: $text)
        }
        
      }
      .padding(20)
      .toolbar {
        // 취소 버튼
        ToolbarItem(placement: .topBarLeading) {
          Button {
            dismiss()
          } label: {
            Text("취소")
              .foregroundStyle(.red)
          }
        }
        
        // MARK: - 저장 로직
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            // 모델컨텍스트에 데이터 insert 하기
            let newLog = LogModel(
              id: UUID(),
              emoji: emotion,
              date: selectDate,
              title: title,
              content: text,
              tag: tagSelection
            )
            modelContext.insert(newLog)
            
            dismiss()
          } label: {
            RoundedRectangle(cornerRadius: 8)
              .fill(text.isEmpty ? Color.gray : Color.green)
              .overlay {
                Text("완료")
                  .foregroundStyle(.white)
              }
              .frame(width: 50, height: 30)
          }
          // MARK: - TODO -> tag 선택까지 필수로 넣어야 버튼이 활성화 되도록 하고 싶음...
          .disabled(title.isEmpty && text.isEmpty)
        }
      }
    }
  }
}

struct CustomTextEditorStyle: ViewModifier {
  
  let placeholder: String
  @Binding var text: String
  
  func body(content: Content) -> some View {
    content
      .padding(15)
      .background(alignment: .topLeading) {
        if text.isEmpty {
          Text(placeholder)
            .lineSpacing(10)
            .padding(20)
            .padding(.top, 2)
            .font(.body)
            .foregroundStyle(Color(UIColor.systemGray2))
        }
      }
      .textInputAutocapitalization(.none)
      .autocorrectionDisabled()
      .background(Color(UIColor.systemGray6))
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .scrollContentBackground(.hidden)
    //여기 고쳐야함 (공부하고 적용해야함..잘 머르겠움..)
    //            .frame(width: .infinity, height: 500)
    //            .frame(width: .infinity, height: .infinity)
      .frame(maxWidth: .infinity)
      .frame(minHeight: 400)
      .overlay(alignment: .bottomTrailing) {
        Text("\(text.count) / 200")
          .padding()
          .onChange(of: text) { oldValue, newValue in
            if newValue.count > 200 {
              text = String(newValue.prefix(200))
            }
          }
      }
  }
}

extension TextEditor {
  func customTextEditor(placeholder: String, userInput: Binding<String>) -> some View {
    self.modifier(CustomTextEditorStyle(placeholder: placeholder, text: userInput))
  }
}


#Preview {
  NewLogView()
        .environmentObject(ThemeManager())
}
