//
//  ListDetailView.swift
//  Remembrance
//
//  Created by JaeyoungLee on 8/11/25.
//

import SwiftUI

struct ListDetailView: View {
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
                    Text("무슨무슨회고 제목")
                        .font(.system(size: 20, weight: .bold))
                    
                    Spacer()
                    
                    Text("\(date, formatter: dateFormat)")
                }
                .padding()
                
                Circle()
                    .frame(width: 200, height: 200)
                    .foregroundStyle(.green)
                    .overlay {
                        VStack {
                            Image(systemName: "fish.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                            Text("여기 페페 이모티콘")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(.white)
                        }
                    }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("내용")
                        .font(.system(size: 17, weight: .bold))
                    
                    TextEditor(text: $text)
                    // MARK: - 메모
                    // TODO: 내용 TextEditor 200자 제한, 글씨 수 셀 수 있는 로직 추가하기
                    // TODO: 프레임을 동적으로 적용할 수 있도록 고려하기 (아이패드도 지원해야 함)
                        .frame(width: 380, height: 400)
                        .border(.blue)
                        .foregroundStyle(Color.gray)
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "chevron.left")
                }
            }
        }
    }
}

#Preview {
    ListDetailView()
}
