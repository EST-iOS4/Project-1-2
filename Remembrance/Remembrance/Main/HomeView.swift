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
                    
                SettingView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Setting")
                    }
                    .tag(2)
            }
            .navigationTitle("나의 Log")
            .onChange(of: selectedTab) { oldValue, newValue in
                print("\(oldValue) => \(newValue)")
                if newValue == 1 {
                    showNewPost = true
                    selectedTab = oldValue
                }
            }
            .sheet(isPresented: $showNewPost){
                SaveView()
            }
        }
    }
}

#Preview {
    HomeView()
}

// TODO: 리스트뷰, 통계뷰, 설정뷰
