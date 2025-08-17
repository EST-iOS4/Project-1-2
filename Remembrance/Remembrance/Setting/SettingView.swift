//
//  SettingView.swift
//  Remembrance
//
//  Created by JaeyoungLee on 8/11/25.
//

import SwiftUI
import SwiftData

struct SettingView: View {
  @Environment(\.dismiss) var dismiss
  @Environment(\.colorScheme) private var scheme
  @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
  @AppStorage("currentTheme") private var currentTheme: String?
//  @AppStorage("userTheme") private var currentTheme: Color =
//  @Environment(\.modelContext) var modelContext
//  @Query private var logContext: [ThemeModel]
//  @State var currentTheme : String?
  @State var themeText = ""
//  let themeModel: ThemeModel
  
  var body: some View {
    VStack {
      VStack {
        HStack {
          Text("설정").font(.title).bold()
          Spacer()
          Button {
            // 글씨크기, 테마 정보 저장 하기
            //UserDefaults.standard.set(currentTheme, forKey: "currentTheme")
            
            dismiss()
          } label: {
            RoundedRectangle(cornerRadius: 8)
              .fill(Color.green)
              .overlay {
                Text("완료")
                  .foregroundStyle(.white)
              }
              .frame(width: 50, height: 30)
          }
        }
        .padding(.bottom, 28)
        
        //폰트사이즈
        VStack (alignment: .leading, spacing: 16){
          Text("폰트사이즈").font(.title3).bold()
          HStack {
            Text("가")
            Slider(value: .constant(10), in: 1...100)
            Text("가")
          }
          .frame(width: .infinity,height: 50)
        }
        
        //테마
        VStack (alignment: .leading, spacing: 16){
          Text("테마").font(.title3).bold()
          
          VStack (spacing: 16){
            Picker("", selection: $currentTheme) {
              Text("기본").tag("기본")
              Text("페페").tag("페페")
              Text("블러썸").tag("블러썸")
            }
            .pickerStyle(.segmented)
            Image(currentTheme ?? "기본")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .clipped()
              .frame(width: 200, height: 200)
              .border(Color.gray)
//            RoundedRectangle(cornerRadius: 15)
//              .frame(width: 150, height: 250)
            Text("\(themeText)")
          }
          
          .onChange(of: currentTheme, initial: true) {
            themeText = "현재 테마는 \(self.currentTheme ?? "기본") 입니다"
            UserDefaults.standard.set(currentTheme, forKey: "currentTheme")
          }
        }
        
      }
    }
    .padding(20)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .frame(width: 370, height: 600)
    .background(.themeBG)
    .clipShape(.rect(cornerRadius: 30))
//    .onAppear() {
////      if UserDefaults.standard.string(forKey: "currentTheme") == nil {
////        currentTheme = "기본"
////      }
//      currentTheme = UserDefaults.standard.string(forKey: "currentTheme") == nil ? "기본" : UserDefaults.standard.string(forKey: "currentTheme")
//    }
  }
}


#Preview {
  SettingView()
}

enum Theme: String, CaseIterable {
  case systemDefault = "Default"
//  case defaultEmoji = "기본"
//  case pepeEmoji = "페페"
  
  
  var colorScheme: ColorScheme? {
    switch self {
    case .systemDefault:
      return nil
    }
  }
}
