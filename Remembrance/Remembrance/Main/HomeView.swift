//
//  HomeView.swift
//  Remembrance
//
//  Created by JaeyoungLee on 8/11/25.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Int = 0
    var body: some View {
        NavigationStack {
            TabView {
                ListView()
                    .tabItem {
                        Image(systemName: "pencil.circle.fill")
                        Text("First")
                    }
                
                Text("plus")
                    .tabItem {
                        Image(systemName: "plus")
                        
                    }
                
                SettingView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Setting")
                    }
            }
            .navigationTitle("나의 Log")
        }
    }
}

#Preview {
    HomeView()
}

// TODO: 리스트뷰, 통계뷰, 설정뷰
