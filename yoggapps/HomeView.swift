//
//  HomeView.swift
//  yoggapps
//  Home Screen for Yoga App
//  Created by Hakan Karakuş on 10.08.2025.
//

import SwiftUI

struct HomeView: View {
    @State private var userName = "Yoga Dostu"
    @State private var showingBreathingExercise = false
    @State private var selectedQuickAction: QuickActionType?
    @State private var showingMoodBased = false
    
    enum QuickActionType: Identifiable {
        case startYoga
        case timeBased
        case locationBased
        case moodBased
        
        var id: Self { self }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    headerSection
                    quickStatsSection
                    dailyGuideSection
                    breathingSection
                    quickActionsSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
            .background(Color("BackgroundColor"))
            .navigationBarHidden(true)
            .sheet(isPresented: $showingBreathingExercise) {
                BreathingExerciseView()
            }
            .sheet(isPresented: Binding(
                get: { selectedQuickAction != nil },
                set: { if !$0 { selectedQuickAction = nil } }
            )) {
                VStack {
                    if let action = selectedQuickAction {
                        Text("Seçilen: \(action)")
                            .padding()
                    }
                }
            }
            .sheet(isPresented: $showingMoodBased) {
                MoodBasedView()
            }
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Merhaba, \(userName)!")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(Color("TextPrimary"))
                    
                    Text("Bugün kendin için ne yapmak istiyorsun?")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                }
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(Color("PrimaryColor"))
                }
            }
        }
    }
    
    private var quickStatsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Bugünkü Durum")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
                QuickStatsCard(
                    title: "Haftalık Seans",
                    value: "5",
                    change: "+2",
                    isPositive: true,
                    icon: "play.circle.fill",
                    color: Color("PrimaryColor")
                )
                
                QuickStatsCard(
                    title: "Toplam Süre",
                    value: "45 dk",
                    change: "+15 dk",
                    isPositive: true,
                    icon: "clock.fill",
                    color: Color("AccentColor")
                )
            }
        }
    }
    
    private var dailyGuideSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Günün Rehberi")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            DailyGuideCard(
                title: "Ofis Sandalye Yogası",
                duration: "6 dk",
                location: "Ofiste",
                description: "Toplantı arası hızlı rahatlama"
            )
        }
    }
    
    private var breathingSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Nefes Çalışması")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(Color("TextPrimary"))
                
                Spacer()
                
                Button(action: {
                    showingBreathingExercise = true
                }) {
                    Text("Başla")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color("TertiaryColor"))
                        .cornerRadius(20)
                }
            }
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "lungs.fill")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(Color("TertiaryColor"))
                        .frame(width: 50, height: 50)
                        .background(Color("TertiaryColor").opacity(0.1))
                        .cornerRadius(25)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("4-4 Nefes Tekniği")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(Color("TextPrimary"))
                        
                        Text("Stres azaltma ve odaklanma için")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(Color("TextSecondary"))
                    }
                    
                    Spacer()
                    
                    Text("5 dk")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(Color("TertiaryColor"))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color("TertiaryColor").opacity(0.1))
                        .cornerRadius(20)
                }
            }
            .padding(20)
            .background(Color("CardBackground"))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
        }
    }
    
    private var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Hızlı Erişim")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
                QuickActionButton(title: "Hemen Yoga Yap", icon: "play.circle.fill") {
                    selectedQuickAction = .startYoga
                }
                QuickActionButton(title: "Zamanına Göre", icon: "clock.fill") {
                    selectedQuickAction = .timeBased
                }
                QuickActionButton(title: "Ortamına Göre", icon: "location.fill") {
                    selectedQuickAction = .locationBased
                }
                QuickActionButton(title: "Ruh Haline Göre", icon: "heart.fill") {
                    selectedQuickAction = .moodBased
                }
            }
        }
    }
    
    private func handleQuickAction(_ action: QuickActionType) {
        // Handle different quick actions
        switch action {
        case .startYoga:
            // Navigate to practice view
            break
        case .timeBased:
            // Show time-based options
            break
        case .locationBased:
            // Show location-based options
            break
        case .moodBased:
            showingMoodBased = true
        }
    }
}



#Preview {
    HomeView()
}
