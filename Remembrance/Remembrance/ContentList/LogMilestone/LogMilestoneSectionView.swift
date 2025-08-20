//
//  LogMilestoneSectionView.swift
//  Remembrance
//
//  Created by 엄정민 on 8/17/25.
//
import SwiftUI
import SwiftData

struct LogMilestoneSectionView: View {
  @Binding var milestones: [MilestoneItem]
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack{
        VStack (alignment: .leading) {
          Text("글자가 1cm 라면?")
            .font(.caption2).fontWeight(.semibold)
          if milestones[1].centimeter < 1{
            Text("현재 \(milestones[1].centimeter) cm 입니다!")
              .font(.body).fontWeight(.bold)
              .padding(.bottom, 6)
          }else if milestones[1].centimeter < 100 {
            Text("\(milestones[1].centimeter)cm 를 작성하셨네요!")
              .font(.body).fontWeight(.bold)
              .padding(.bottom, 6)
            Text("\(milestones[1].name)")
              .font(.footnote)
          }else{
            Text("\(milestones[1].meter)를 작성하셨네요!")
              .font(.body).fontWeight(.bold)
              .padding(.bottom, 6)
            Text("\(milestones[1].name)")
              .font(.footnote)
          }
          
        }
        .padding(.leading, 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        VStack{
          if milestones[1].centimeter < 1{
            Image(milestones[1].imageName)
              .resizable()
              .scaledToFit()
              .scaleEffect(0.8)
          }else if milestones[1].centimeter < 100 {
            Image(milestones[1].imageName)
              .resizable()
              .scaledToFit()
              .scaleEffect(0.8)
          }else{
            Image(milestones[1].imageName)
              .resizable()
              .scaledToFit()
              .scaleEffect(0.8)
            
          }
        }
        .frame(maxHeight: .infinity, alignment: .bottomTrailing)
      }
    }.background(Color(.systemGray4))
      .cornerRadius(12)
  }
}

