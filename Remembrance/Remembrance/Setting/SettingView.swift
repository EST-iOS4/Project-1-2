//
//  SettingView.swift
//  Remembrance
//
//  Created by JaeyoungLee on 8/11/25.
//

import SwiftUI

struct SettingView: View {
  @Environment(\.colorScheme) private var scheme
  @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
  @Namespace private var animation
  @State var currentTheme = Color.orange
  @State var themeText = ""
  
  var body: some View {
    VStack (alignment: .leading){
      HStack {
        Text("설정").font(.title).bold()
        Spacer()
        Button {
          // 글씨크기, 테마 정보 저장 하기
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
        .padding(.bottom, 28)
      }
      
      //테마
      VStack (alignment: .leading, spacing: 16){
        Text("테마").font(.title3).bold()
        
        VStack (spacing: 16){
          Picker("", selection: $currentTheme) {
            Text("Orange").tag(Color.orange)
            Text("Pink").tag(Color.pink)
            Text("Purple").tag(Color.purple)
          }
          .pickerStyle(.segmented)
          RoundedRectangle(cornerRadius: 15)
            .fill(currentTheme)
            .frame(width: 150, height: 250)
          Text("\(themeText)")
        }
        
        .onChange(of: currentTheme, initial: true) {
          themeText = "현재 테마는 \(self.currentTheme) 입니다"
        }
      }
      
    }
    .frame(width: .infinity, height: 600)
    .padding(20)
  }
}


#Preview {
  SettingView()
}

enum Theme: String, CaseIterable {
  case systemDefault = "Default"
  case light = "Light"
  case dark = "Dark"
  
  func color(_ scheme: ColorScheme) -> Color {
    switch self {
    case .systemDefault:
      return scheme == .dark ? .moon : .sun
    case .light:
      return .sun
    case .dark:
      return .moon
    }
  }
  
  var colorScheme: ColorScheme? {
    switch self {
    case .systemDefault:
      return nil
    case .light:
      return .light
    case .dark:
      return .dark
    }
  }
}
