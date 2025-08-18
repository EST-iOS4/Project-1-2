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
  @EnvironmentObject var themeManager : ThemeManager
  @State var themeText = ""
  
  var body: some View {
    VStack {
      VStack {
        HStack {
          Text("설정")
            .font(.title).bold()
          Spacer()
          Button {
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
//        VStack (alignment: .leading, spacing: 16){
//          Text("텍스트 크기 - 현재 값은 : \(fontSize)")
//            .font(.system(size: CGFloat(fontSize)))
//            .font(.title3).bold()
//          HStack {
//            Text("가")
//              .font(.callout)
//            Slider(value: $fontSize, in: 14...38, step: 2)
//            Text("가")
//              .font(.title2)
//          }
//        }
//        .padding(.bottom, 28)
        
        //테마
        VStack (alignment: .leading, spacing: 16){
          Text("테마").font(.title3).bold()
          
          VStack (spacing: 16){
            Picker("", selection: $themeManager.currentTheme) {
              Text("기본").tag("emoji")
              Text("페페").tag("pepe")
              Text("블러썸").tag("blossom")
            }
            .pickerStyle(.segmented)
            RoundedRectangle(cornerRadius: 20)
              .frame(width: 255, height: 255)
              .foregroundStyle(.gray)
              .overlay{
                Image("\(themeManager.currentTheme)Main")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .clipped()
                  .frame(width: 250, height: 250)
                  .cornerRadius(18)
              }
            
            Text("\(themeText)")
          }
          
          .onChange(of: themeManager.currentTheme, initial: true) {
            themeText = "현재 테마는 \(themeDisplayName(for: themeManager.currentTheme)) 입니다"

          }
        }
        Spacer()
        
      }
    }
    .padding(20)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .frame(width: 370, height: 500)
    .background(.themeBG)
    .clipShape(.rect(cornerRadius: 30))
  }
}


#Preview {
  SettingView()
}
