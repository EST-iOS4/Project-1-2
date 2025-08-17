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
                Text("글자가 1cm 라면?")
                    .font(.title2).fontWeight(.semibold)
                    .foregroundColor(.black)
            }
        }
    }
}
