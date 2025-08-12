//
//  SaveView.swift
//  Remembrance
//
//  Created by NaSangJin on 8/12/25.
//

import SwiftUI
import SwiftData

struct SaveView: View {
  @Environment(\.dismiss) var dismiss
  @Environment(\.modelContext) var modelContext
  @Query private var logContext: [LogModel]
  @State private var title: String = ""
  @State private var text: String = ""
  private let placeholder: String = "Type something..."
  @State private var tagDatas: [String] = ["#태그1", "#태그2", "#태그3"]
  
  var body: some View {
    NavigationStack {
      VStack {
        //기본으로 오늘 날짜 표기, 변경가능
        Text("2025-07-22")
        HStack {
          Circle()
            .frame(width: 50, height: 50)
          Circle()
            .frame(width: 50, height: 50)
          Circle()
            .frame(width: 50, height: 50)
          Circle()
            .frame(width: 50, height: 50)
          Circle()
            .frame(width: 50, height: 50)
          Circle()
            .frame(width: 50, height: 50)
        }
        TextField("제목", text:$title).font(.system(size: 18))
        VStack(alignment: .leading) {
          Text("내용")
          TextEditor(text: $text).customTextEditor(placeholder: placeholder, userInput: $text)
          Picker("", selection: $tagDatas) {
            ForEach (tagDatas, id: \.self) {
              tagData in
              Text(tagData)
                .frame(width: 40)
            }
          }
          .pickerStyle(.segmented)
        }
        
      }
      .padding(20)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button {
            dismiss()
          } label: {
            Image(systemName: "x.circle.fill")
          }
        }
        
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            // save() 로직 구현
          } label: {
            Image(systemName: "checkmark")
          }
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
            .font(.system(size: 14))
            .foregroundStyle(Color(UIColor.systemGray2))
        }
      }
      .textInputAutocapitalization(.none)
      .autocorrectionDisabled()
      .background(Color(UIColor.systemGray6))
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .scrollContentBackground(.hidden)
      .frame(width: .infinity, height: 500)
      .overlay(alignment: .bottomTrailing) {
        Text("(text.count) / 200")
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
  SaveView()
}
