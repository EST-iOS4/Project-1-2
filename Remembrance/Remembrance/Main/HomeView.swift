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
        VStack {
            ContentListView()
        }.task {
            // 앱 첫 진입 시 1회 시드
            try? seedEmojisIfNeeded(context: modelContext)
        }
    }
}



#Preview {
    HomeView()
}

// TODO: 리스트뷰, 통계뷰, 설정뷰
