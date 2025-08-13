//
//  SaveView.swift
//  Remembrance
//
//  Created by NaSangJin on 8/12/25.
//

import SwiftUI
import SwiftData

// MARK: - 임시 circle 데이터
enum CircleColor: CaseIterable {
    case blue
    case green
    case gray
    case brown
    case cyan
    case red
    
    @ViewBuilder
    var circleImage: some View {
        switch self {
        case .blue:
            Circle()
                .frame(width: 50, height: 50)
                .foregroundStyle(.blue)
        case .green:
            Circle()
                .frame(width: 50, height: 50)
                .foregroundStyle(.green)
        case .gray:
            Circle()
                .frame(width: 50, height: 50)
                .foregroundStyle(.gray)
        case .brown:
            Circle()
                .frame(width: 50, height: 50)
                .foregroundStyle(.brown)
        case .cyan:
            Circle()
                .frame(width: 50, height: 50)
                .foregroundStyle(.cyan)
        case .red:
            Circle()
                .frame(width: 50, height: 50)
                .foregroundStyle(.red)
        }
    }
}

struct SaveView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Query private var logContext: [LogModel]
    
    @State private var title: String = ""
    @State private var text: String = ""
    @State private var tagDatas: [String] = ["#태그1", "#태그2", "#태그3"]
    @State private var selectDate: Date = Date()
    
    // 텍스트 에디터 초기 글자
    private let placeholder: String = "Type something..."
    
    let date = Date()
    let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    let circles: [CircleColor] = CircleColor.allCases
    
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("\(selectDate, formatter: dateFormat)")
                    
                    DatePicker("", selection: $selectDate, displayedComponents: [.date])
                        .datePickerStyle(.compact)
                }
                
                HStack {
                    ForEach(circles, id: \.self) { circles in
                        Button {
                            
                        } label: {
                            circles.circleImage
                        }
                        
                    }
                }
                .background()
                
                TextField("제목", text:$title).font(.system(size: 18))
                    .padding(3)
                    .border(.black, width: 1)
                
                VStack(alignment: .leading) {
                    Text("내용")
                    TextEditor(text: $text).customTextEditor(placeholder: placeholder, userInput: $text)
                    Picker("", selection: $tagDatas) {
                        ForEach (tagDatas, id: \.self) { tagData in
                            Text(tagData)
                                .frame(width: 40)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
            }
            .padding(20)
            .toolbar {
                // 취소 버튼
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle.fill")
                    }
                }
                
                // 저장 버튼
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // 모델컨텍스트에 데이터 insert 하기
                        let newLog = LogModel(
                            id: UUID(),
                            emoji: "",
                            date: selectDate,
                            title: title,
                            content: text,
                            tag: ""
                        )
                        modelContext.insert(newLog)
                        
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .disabled(text.isEmpty)
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
    SaveView()
}
