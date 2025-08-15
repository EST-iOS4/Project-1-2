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
            //커스텀네비게이션바 만들어서 월별이동, 현재날짜표시
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
        }
        // MARK: - 이부분 말해보기
        .safeAreaInset(edge: .bottom) {
            NavigationLink(destination: SaveView()) {
                HStack{
                    Spacer()
                    
                    Button{}label: {
                        Image(systemName: "square.and.pencil")
                            .font(.title3)
                            .padding(.top,10)
                        //                        .resizable()
                        //                        .scaledToFit()     원본 비율 유지해서 맞추기
                    }
                    
                    .foregroundStyle(Color.black)
                }
                
                .padding(.trailing, 20)
                .padding(.bottom, 20)
                .frame(height: 56)
                .background(.ultraThinMaterial)
            }
        }
    }
}


#Preview {
    HomeView()
}

// TODO: 리스트뷰, 통계뷰, 설정뷰
