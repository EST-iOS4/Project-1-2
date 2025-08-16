//
//  HomeView.swift
//  Remembrance
//
//  Created by JaeyoungLee on 8/11/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var selectedTab: Int = 0
    @State private var showNewPost: Bool = false
    @State private var showSettingView: Bool = false
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                ListView()
                    .tabItem {
                        Image(systemName: "pencil.circle.fill")
                        Text("First")
                    }
                    .tag(0)
                
                Text("plus")
                    .tabItem {
                        Image(systemName: "plus")
                    }
                    .tag(1)
                    
//                SettingView()
              Text("Setting")
                    .tabItem {
                        Image(systemName: "gear")
                       
                    }
                    .tag(2)
            }
            
          //커스텀네비게이션바 만들어서 월별이동, 현재날짜표시
            .navigationTitle("AUGUST")
            .onChange(of: selectedTab) { oldValue, newValue in
                print("\(oldValue) => \(newValue)")
                if newValue == 1 {
                    showNewPost = true
                    selectedTab = oldValue
                }
            }
            .fullScreenCover(isPresented: $showNewPost) {
              SaveView()
            }
//            .sheet(isPresented: $showNewPost){
//                SaveView()
//            }
        }.sheet(isPresented: $showSettingView, content: {
          SettingView()
            .presentationDetents([.height(600)])
            .presentationBackground(Color.black.opacity(0.4))
        })
    }
}

#Preview {
    HomeView()
}

// TODO: 리스트뷰, 통계뷰, 설정뷰
