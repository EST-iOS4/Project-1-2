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
    var body: some View {
      VStack(alignment: .leading, spacing: 8) {
        Text("설정하기").font(.title).bold()
        
        Text("폰트사이즈").font(.title3).bold()
        HStack {
          Text("가")
          Slider(value: .constant(10), in: 1...100)
          Text("가")
        }
        .frame(width: .infinity,height: 50)
        .background(Color.blue)
        Text("테마").font(.title3).bold()
        VStack(spacing: 8) {
          Circle()
            .fill(userTheme.color(scheme).gradient)
            .frame(width: 150, height: 150)
          Text("테마를 변경해보세요")
            .font(.title2.bold())
            .padding()
          
          HStack {
            ForEach(Theme.allCases, id: \.rawValue) { theme in
              Text(theme.rawValue)
                .padding(.vertical, 10)
                .frame(width: 100)
                .background{
                  ZStack{
                    if userTheme == theme {
                      Capsule()
                        .fill(.themeBG)
                        .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                  }
                  .animation(.snappy, value: userTheme)
                }
                .contentShape(.rect)
                .onTapGesture{
                  userTheme = theme
                }
            }
          }
          .padding(3)
          .background(.primary.opacity(0.06), in: .capsule)
          .padding(.top, 20)
        }
        .frame(width: .infinity)
      }
//      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .padding(20)
//      .background(.themeBG)
      .background(Color.brown)
      .environment(\.colorScheme, scheme)
      .preferredColorScheme(userTheme.colorScheme)
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
