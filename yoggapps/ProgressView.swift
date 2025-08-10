//
//  ProgressView.swift
//  yoggapps
//  Progress Tracking and Statistics
//  Created by Hakan Karakuş on 10.08.2025.
//

import SwiftUI

struct ProgressView: View {
    @State private var selectedTimeRange: TimeRange = .week
    @State private var showingAchievements = false
    @State private var showingDetailedStats = false
    
    enum TimeRange: String, CaseIterable {
        case week = "Hafta"
        case month = "Ay"
        case year = "Yıl"
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header with Time Range Selector
                    headerSection
                    
                    // Overall Progress Summary
                    overallProgressSection
                    
                    // Weekly Progress Chart
                    weeklyProgressSection
                    
                    // Practice Statistics
                    practiceStatsSection
                    
                    // Achievements
                    achievementsSection
                    
                    // Streak Information
                    streakSection
                    
                    // Goals
                    goalsSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
            .background(Color("BackgroundColor"))
            .navigationBarHidden(true)
            .sheet(isPresented: $showingAchievements) {
                AchievementsView()
            }
            .sheet(isPresented: $showingDetailedStats) {
                DetailedStatsView()
            }
        }
    }
    
    private var headerSection: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("İlerleme")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(Color("TextPrimary"))
                    
                    Text("Yoga yolculuğundaki gelişimini takip et")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                }
                
                Spacer()
                
                Button(action: {
                    showingDetailedStats = true
                }) {
                    Image(systemName: "chart.bar.fill")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(Color("PrimaryColor"))
                        .frame(width: 40, height: 40)
                        .background(Color("PrimaryColor").opacity(0.1))
                        .cornerRadius(20)
                }
            }
            
            // Time Range Selector
            HStack(spacing: 12) {
                ForEach(TimeRange.allCases, id: \.self) { range in
                    Button(action: {
                        selectedTimeRange = range
                    }) {
                        Text(range.rawValue)
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(selectedTimeRange == range ? .white : Color("TextPrimary"))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(selectedTimeRange == range ? Color("PrimaryColor") : Color("CardBackground"))
                            .cornerRadius(20)
                    }
                }
            }
        }
    }
    
    private var overallProgressSection: some View {
        VStack(spacing: 16) {
            Text("Genel İlerleme")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                ProgressMetricCard(
                    title: "Toplam Seans",
                    value: "47",
                    change: "+12",
                    isPositive: true,
                    icon: "play.circle.fill",
                    color: Color("PrimaryColor")
                )
                
                ProgressMetricCard(
                    title: "Toplam Süre",
                    value: "23.5 saat",
                    change: "+5.2 saat",
                    isPositive: true,
                    icon: "clock.fill",
                    color: Color("AccentColor")
                )
                
                ProgressMetricCard(
                    title: "Haftalık Ortalama",
                    value: "4.2 seans",
                    change: "+0.8",
                    isPositive: true,
                    icon: "chart.line.uptrend.xyaxis",
                    color: Color("SecondaryColor")
                )
                
                ProgressMetricCard(
                    title: "Mevcut Seri",
                    value: "8 gün",
                    change: "+3 gün",
                    isPositive: true,
                    icon: "flame.fill",
                    color: Color("TertiaryColor")
                )
            }
        }
    }
    
    private var weeklyProgressSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Haftalık İlerleme")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(Color("TextPrimary"))
                
                Spacer()
                
                Text("Bu Hafta")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(Color("TextSecondary"))
            }
            
            ProgressChart(
                data: [5, 3, 7, 4, 6, 8, 5],
                labels: ["Pzt", "Sal", "Çar", "Per", "Cum", "Cmt", "Paz"],
                target: 6
            )
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Haftalık Hedef")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                    
                    Text("6 seans")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(Color("PrimaryColor"))
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Tamamlanan")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                    
                    Text("5/6 seans")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(Color("TextPrimary"))
                }
            }
            .padding(.top, 8)
        }
    }
    
    private var practiceStatsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Pratik İstatistikleri")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            VStack(spacing: 12) {
                StatRow(
                    title: "En Uzun Seans",
                    value: "45 dakika",
                    subtitle: "Vinyasa Flow - 2 gün önce",
                    icon: "clock.fill",
                    color: Color("PrimaryColor")
                )
                
                StatRow(
                    title: "En Çok Yapılan",
                    value: "Sabah Yogası",
                    subtitle: "12 kez bu ay",
                    icon: "sunrise.fill",
                    color: Color("AccentColor")
                )
                
                StatRow(
                    title: "Ortalama Süre",
                    value: "18.5 dakika",
                    subtitle: "Seans başına",
                    icon: "chart.bar.fill",
                    color: Color("SecondaryColor")
                )
                
                StatRow(
                    title: "Favori Zaman",
                    value: "07:00-08:00",
                    subtitle: "Sabah erken",
                    icon: "moon.stars.fill",
                    color: Color("TertiaryColor")
                )
            }
        }
    }
    
    private var achievementsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Başarılar")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(Color("TextPrimary"))
                
                Spacer()
                
                Button("Tümünü Gör") {
                    showingAchievements = true
                }
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(Color("PrimaryColor"))
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(getAchievements(), id: \.id) { achievement in
                        AchievementCard(achievement: achievement)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
    
    private var streakSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Seri Bilgisi")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            HStack(spacing: 20) {
                VStack(spacing: 8) {
                    Text("8")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(Color("TertiaryColor"))
                    
                    Text("Günlük Seri")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                }
                
                VStack(spacing: 8) {
                    Text("12")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(Color("SecondaryColor"))
                    
                    Text("En Uzun Seri")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                }
                
                VStack(spacing: 8) {
                    Text("23")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(Color("AccentColor"))
                    
                    Text("Toplam Gün")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(20)
            .background(Color("CardBackground"))
            .cornerRadius(20)
        }
    }
    
    private var goalsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Hedefler")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            VStack(spacing: 12) {
                GoalRow(
                    title: "Haftalık 6 Seans",
                    progress: 0.83,
                    current: "5",
                    target: "6",
                    icon: "calendar",
                    color: Color("PrimaryColor")
                )
                
                GoalRow(
                    title: "Aylık 100 Dakika",
                    progress: 0.65,
                    current: "65",
                    target: "100",
                    icon: "clock.fill",
                    color: Color("AccentColor")
                )
                
                GoalRow(
                    title: "30 Günlük Seri",
                    progress: 0.27,
                    current: "8",
                    target: "30",
                    icon: "flame.fill",
                    color: Color("TertiaryColor")
                )
            }
        }
    }
    
    private func getAchievements() -> [Achievement] {
        return [
            Achievement(id: UUID(), title: "İlk Adım", description: "İlk yoga seansını tamamladın", icon: "star.fill", color: Color("PrimaryColor"), isUnlocked: true),
            Achievement(id: UUID(), title: "Haftalık", description: "Bir hafta boyunca yoga yaptın", icon: "calendar", color: Color("AccentColor"), isUnlocked: true),
            Achievement(id: UUID(), title: "Seri", description: "5 gün üst üste yoga yaptın", icon: "flame.fill", color: Color("TertiaryColor"), isUnlocked: true),
            Achievement(id: UUID(), title: "Süre", description: "Toplam 10 saat yoga yaptın", icon: "clock.fill", color: Color("SecondaryColor"), isUnlocked: false)
        ]
    }
}

struct ProgressMetricCard: View {
    let title: String
    let value: String
    let change: String
    let isPositive: Bool
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(color)
                    .frame(width: 40, height: 40)
                    .background(color.opacity(0.1))
                    .cornerRadius(20)
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: isPositive ? "arrow.up" : "arrow.down")
                        .font(.system(size: 12, weight: .bold))
                    Text(change)
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                }
                .foregroundColor(isPositive ? .green : .red)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background((isPositive ? Color.green : Color.red).opacity(0.1))
                .cornerRadius(12)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(value)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(Color("TextPrimary"))
                
                Text(title)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(Color("TextSecondary"))
            }
        }
        .padding(16)
        .background(Color("CardBackground"))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

struct StatRow: View {
    let title: String
    let value: String
    let subtitle: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(color)
                .frame(width: 40, height: 40)
                .background(color.opacity(0.1))
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(Color("TextSecondary"))
                
                Text(value)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(Color("TextPrimary"))
                
                Text(subtitle)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(Color("TextSecondary"))
            }
            
            Spacer()
        }
        .padding(16)
        .background(Color("CardBackground"))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

struct Achievement: Identifiable {
    let id: UUID
    let title: String
    let description: String
    let icon: String
    let color: Color
    let isUnlocked: Bool
}

struct AchievementCard: View {
    let achievement: Achievement
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: achievement.icon)
                .font(.system(size: 32, weight: .medium))
                .foregroundColor(achievement.isUnlocked ? achievement.color : Color("TextSecondary"))
                .frame(width: 60, height: 60)
                .background((achievement.isUnlocked ? achievement.color : Color("TextSecondary")).opacity(0.1))
                .cornerRadius(30)
            
            VStack(spacing: 4) {
                Text(achievement.title)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(achievement.isUnlocked ? Color("TextPrimary") : Color("TextSecondary"))
                    .multilineTextAlignment(.center)
                
                Text(achievement.description)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(Color("TextSecondary"))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
        }
        .padding(16)
        .frame(width: 140)
        .background(Color("CardBackground"))
        .cornerRadius(20)
        .opacity(achievement.isUnlocked ? 1.0 : 0.6)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

struct GoalRow: View {
    let title: String
    let progress: Double
    let current: String
    let target: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(color)
                .frame(width: 40, height: 40)
                .background(color.opacity(0.1))
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("TextPrimary"))
                    
                    Spacer()
                    
                    Text("\(current)/\(target)")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                }
                
                ProgressBar(progress: progress, color: color)
            }
        }
        .padding(16)
        .background(Color("CardBackground"))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

struct ProgressBar: View {
    let progress: Double
    let color: Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color("CardBackground"))
                    .frame(height: 8)
                    .cornerRadius(4)
                
                Rectangle()
                    .fill(color)
                    .frame(width: geometry.size.width * progress, height: 8)
                    .cornerRadius(4)
            }
        }
        .frame(height: 8)
    }
}

struct AchievementsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                    ForEach(getAllAchievements(), id: \.id) { achievement in
                        AchievementCard(achievement: achievement)
                    }
                }
                .padding(20)
            }
            .background(Color("BackgroundColor"))
            .navigationTitle("Başarılar")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Kapat") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func getAllAchievements() -> [Achievement] {
        return [
            Achievement(id: UUID(), title: "İlk Adım", description: "İlk yoga seansını tamamladın", icon: "star.fill", color: Color("PrimaryColor"), isUnlocked: true),
            Achievement(id: UUID(), title: "Haftalık", description: "Bir hafta boyunca yoga yaptın", icon: "calendar", color: Color("AccentColor"), isUnlocked: true),
            Achievement(id: UUID(), title: "Seri", description: "5 gün üst üste yoga yaptın", icon: "flame.fill", color: Color("TertiaryColor"), isUnlocked: true),
            Achievement(id: UUID(), title: "Süre", description: "Toplam 10 saat yoga yaptın", icon: "clock.fill", color: Color("SecondaryColor"), isUnlocked: false),
            Achievement(id: UUID(), title: "Sabah", description: "7 gün üst üste sabah yogası", icon: "sunrise.fill", color: Color("AccentColor"), isUnlocked: false),
            Achievement(id: UUID(), title: "Uzman", description: "100 seans tamamladın", icon: "crown.fill", color: Color("TertiaryColor"), isUnlocked: false)
        ]
    }
}

struct DetailedStatsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Detailed statistics would go here
                    Text("Detaylı İstatistikler")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(Color("TextPrimary"))
                    
                    Text("Bu sayfa geliştirilme aşamasında...")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                }
                .padding(20)
            }
            .background(Color("BackgroundColor"))
            .navigationTitle("Detaylı İstatistikler")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Kapat") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    ProgressView()
}
