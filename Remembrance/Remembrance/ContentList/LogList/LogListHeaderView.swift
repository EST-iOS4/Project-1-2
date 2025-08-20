//
//  Untitled.swift
//  Remembrance
//
//  Created by 엄정민 on 8/17/25.
//

import SwiftUI
import SwiftData

// MARK: - 로그리스트 헤더
struct LogListHeaderView: View {
  var body: some View {
    HStack{
      Text("이달의 회고기록")
        .font(.body).fontWeight(.black)
      Spacer()
      HStack{
        Text("태그 선택")
          .font(.footnote)
        Image(systemName: "chevron.down")
          .font(.footnote)
      }
      
    }
  }
}
