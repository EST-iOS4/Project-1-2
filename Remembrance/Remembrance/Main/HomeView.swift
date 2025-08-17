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
          Button("Setting") {
            showSettingView.toggle()
          }
            TabView(selection: $selectedTab) {
                ContentListView()
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
                
                SettingView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Setting")
                    }
                    .tag(2)
            }
            //커스텀네비게이션바 만들어서 월별이동, 현재날짜표시
            .onChange(of: selectedTab) { oldValue, newValue in
                print("\(oldValue) => \(newValue)")
                if newValue == 1 {
                    showNewPost = true
                    selectedTab = oldValue
                }
            }
            .sheet(isPresented: $showSettingView, content: {
                      SettingView()
                        .presentationDetents([.height(600)])
                        .presentationBackground(Color.clear)
                    })
            .fullScreenCover(isPresented: $showNewPost) {
                SaveView()
            }
            //            .sheet(isPresented: $showNewPost){
            //                SaveView()
            //            }
        }
        .task {
            // 앱 첫 진입 시 1회 시드
            try? seedEmojisIfNeeded(context: modelContext)
        }
    }
}



#Preview {
    HomeView()
}

// TODO: 리스트뷰, 통계뷰, 설정뷰
