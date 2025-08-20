//
//  LogMilestoneHeaderView.swift
//  Remembrance
//
//  Created by 엄정민 on 8/17/25.
//
import SwiftUI
import SwiftData

struct LogMilestoneHeaderView: View{
    
    var body: some View{
        VStack(alignment: .leading){
            Spacer()
            HStack{
                Text("지금까지 작성한 글을 cm로 환산했어요!")
                .font(.body).fontWeight(.black)
            }
        }
    }
}
