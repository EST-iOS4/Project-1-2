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
        VStack{
            Spacer()
            HStack{
                Text("기록")
                    .font(.title).fontWeight(.bold)
                Spacer()
                HStack{
                    Text("태그 선택")
                        .font(.footnote)
                    Image(systemName: "chevron.down")
                        .font(.footnote)
                }

            }
            Spacer()
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 20)
        }
    }
}
