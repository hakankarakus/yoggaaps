//
//  MainTabView.swift
//  yoggapps
//  Main Tab Navigation for Yoga App
//  Created by Hakan Karakuş on 10.08.2025.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Ana Sayfa")
                }
                .tag(0)
            
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Keşfet")
                }
                .tag(1)
            
            PracticeView()
                .tabItem {
                    Image(systemName: "play.circle.fill")
                    Text("Yoga Yap")
                }
                .tag(2)
            
            ProgressView()
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("İlerleme")
                }
                .tag(3)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Profil")
                }
                .tag(4)
        }
        .accentColor(Color("PrimaryColor"))
        .background(Color("BackgroundColor"))
    }
}

#Preview {
    MainTabView()
}
