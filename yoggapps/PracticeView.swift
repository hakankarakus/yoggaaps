//
//  PracticeView.swift
//  yoggapps
//  Practice Session Selection and Management
//  Created by Hakan Karakuş on 10.08.2025.
//

import SwiftUI

struct PracticeView: View {
    @State private var selectedTimeFilter: TimeFilter = .all
    @State private var selectedCategory: PracticeCategory = .all
    @State private var showingSessionDetail = false
    @State private var selectedSession: PracticeSession?
    @State private var searchText = ""
    
    enum TimeFilter: String, CaseIterable {
        case all = "Tümü"
        case short = "Kısa (5-15 dk)"
        case medium = "Orta (15-30 dk)"
        case long = "Uzun (30+ dk)"
    }
    
    enum PracticeCategory: String, CaseIterable {
        case all = "Tümü"
        case morning = "Sabah"
        case evening = "Akşam"
        case stress = "Stres Azaltma"
        case energy = "Enerji"
        case flexibility = "Esneklik"
        case strength = "Güç"
        case balance = "Denge"
        case meditation = "Meditasyon"
        case office = "Ofis"
        case travel = "Seyahat"
    }
    
    enum YogaLevel: String, CaseIterable {
        case beginner = "Başlangıç"
        case intermediate = "Orta"
        case advanced = "İleri"
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                headerSection
                
                // Filters
                filterSection
                
                // Content
                ScrollView {
                    LazyVStack(spacing: 24) {
                        // Quick Start Section
                        quickStartSection
                        
                        // Recommended Sessions
                        recommendedSection
                        
                        // Category-based Sessions
                        categorySessionsSection
                        
                        // Recent Sessions
                        recentSessionsSection
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                }
            }
            .background(Color("BackgroundColor"))
            .navigationBarHidden(true)
            .sheet(isPresented: $showingSessionDetail) {
                if let session = selectedSession {
                    PracticeSessionView(session: session)
                }
            }
        }
    }
    
    private var headerSection: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Yoga Yap")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(Color("TextPrimary"))
                    
                    Text("Bugün hangi seansı yapmak istiyorsun?")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                }
                
                Spacer()
                
                Button(action: {
                    // Show practice history
                }) {
                    Image(systemName: "clock.arrow.circlepath")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(Color("PrimaryColor"))
                        .frame(width: 40, height: 40)
                        .background(Color("PrimaryColor").opacity(0.1))
                        .cornerRadius(20)
                }
            }
            
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color("TextSecondary"))
                
                TextField("Seans ara...", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color("TextSecondary"))
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color("CardBackground"))
            .cornerRadius(25)
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
    
    private var filterSection: some View {
        VStack(spacing: 16) {
            // Time Filter
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(TimeFilter.allCases, id: \.self) { filter in
                        Button(action: {
                            selectedTimeFilter = filter
                        }) {
                            Text(filter.rawValue)
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundColor(selectedTimeFilter == filter ? .white : Color("TextPrimary"))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(selectedTimeFilter == filter ? Color("PrimaryColor") : Color("CardBackground"))
                                .cornerRadius(20)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            
            // Category Filter
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(PracticeCategory.allCases, id: \.self) { category in
                        Button(action: {
                            selectedCategory = category
                        }) {
                            Text(category.rawValue)
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundColor(selectedCategory == category ? .white : Color("TextPrimary"))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(selectedCategory == category ? Color("PrimaryColor") : Color("CardBackground"))
                                .cornerRadius(20)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
    
    private var quickStartSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Hızlı Başlangıç")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                QuickStartCard(
                    title: "5 Dakika",
                    subtitle: "Hızlı Rahatlama",
                    icon: "clock.fill",
                    color: Color("PrimaryColor"),
                    duration: "5 dk"
                ) {
                    startQuickSession(duration: 5)
                }
                
                QuickStartCard(
                    title: "10 Dakika",
                    subtitle: "Enerji Artırma",
                    icon: "bolt.fill",
                    color: Color("AccentColor"),
                    duration: "10 dk"
                ) {
                    startQuickSession(duration: 10)
                }
                
                QuickStartCard(
                    title: "15 Dakika",
                    subtitle: "Tam Seans",
                    icon: "play.circle.fill",
                    color: Color("SecondaryColor"),
                    duration: "15 dk"
                ) {
                    startQuickSession(duration: 15)
                }
                
                QuickStartCard(
                    title: "Özel",
                    subtitle: "Kendi Süreni Seç",
                    icon: "slider.horizontal.3",
                    color: Color("TertiaryColor"),
                    duration: "Özel"
                ) {
                    showCustomSession()
                }
            }
        }
    }
    
    private var recommendedSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Önerilen Seanslar")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(Color("TextPrimary"))
                
                Spacer()
                
                Button("Tümünü Gör") {
                    // Show all recommended
                }
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(Color("PrimaryColor"))
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(getRecommendedSessions(), id: \.id) { session in
                        RecommendedSessionCard(session: session) {
                            selectedSession = session
                            showingSessionDetail = true
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
    
    private var categorySessionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Kategoriye Göre")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                ForEach(getCategorySessions(), id: \.id) { session in
                    PracticeSessionCard(session: session) {
                        selectedSession = session
                        showingSessionDetail = true
                    }
                }
            }
        }
    }
    
    private var recentSessionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Son Seanslar")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(Color("TextPrimary"))
                
                Spacer()
                
                Button("Tümünü Gör") {
                    // Show all recent
                }
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(Color("PrimaryColor"))
            }
            
            VStack(spacing: 12) {
                ForEach(getRecentSessions(), id: \.id) { session in
                    RecentSessionRow(session: session) {
                        selectedSession = session
                        showingSessionDetail = true
                    }
                }
            }
        }
    }
    
    private func startQuickSession(duration: Int) {
        let quickSession = PracticeSession(
            id: UUID(),
            title: "\(duration) Dakikalık Hızlı Seans",
            description: "Hızlı rahatlama ve enerji artırma",
            duration: duration,
            category: .energy,
            level: .beginner,
            poses: [],
            isRecommended: false
        )
        selectedSession = quickSession
        showingSessionDetail = true
    }
    
    private func showCustomSession() {
        // Show custom session creation
    }
    
    private func getRecommendedSessions() -> [PracticeSession] {
        return [
            PracticeSession(id: UUID(), title: "Sabah Enerjisi", description: "Güne dinamik başlangıç", duration: 15, category: .morning, level: .beginner, poses: [], isRecommended: true),
            PracticeSession(id: UUID(), title: "Stres Azaltma", description: "Günlük stresi azalt", duration: 20, category: .stress, level: .beginner, poses: [], isRecommended: true),
            PracticeSession(id: UUID(), title: "Ofis Rahatlaması", description: "İş yerinde hızlı rahatlama", duration: 10, category: .office, level: .beginner, poses: [], isRecommended: true)
        ]
    }
    
    private func getCategorySessions() -> [PracticeSession] {
        return [
            PracticeSession(id: UUID(), title: "Temel Duruşlar", description: "Yogaya yeni başlayanlar için", duration: 25, category: .flexibility, level: .beginner, poses: [], isRecommended: false),
            PracticeSession(id: UUID(), title: "Vinyasa Flow", description: "Dinamik yoga akışı", duration: 30, category: .energy, level: .intermediate, poses: [], isRecommended: false),
            PracticeSession(id: UUID(), title: "Yin Yoga", description: "Derin esneklik ve rahatlama", duration: 45, category: .flexibility, level: .intermediate, poses: [], isRecommended: false),
            PracticeSession(id: UUID(), title: "Meditasyon", description: "Zihinsel dinginlik", duration: 20, category: .meditation, level: .beginner, poses: [], isRecommended: false)
        ]
    }
    
    private func getRecentSessions() -> [PracticeSession] {
        return [
            PracticeSession(id: UUID(), title: "Sabah Yogası", description: "Dün yapılan seans", duration: 15, category: .morning, level: .beginner, poses: [], isRecommended: false),
            PracticeSession(id: UUID(), title: "Stres Azaltma", description: "2 gün önce yapılan", duration: 20, category: .stress, level: .beginner, poses: [], isRecommended: false)
        ]
    }
}

struct PracticeSession: Identifiable {
    let id: UUID
    let title: String
    let description: String
    let duration: Int
    let category: PracticeView.PracticeCategory
    let level: PracticeView.YogaLevel
    let poses: [String]
    let isRecommended: Bool
}

struct QuickStartCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let duration: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                HStack {
                    Image(systemName: icon)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(color)
                        .frame(width: 50, height: 50)
                        .background(color.opacity(0.1))
                        .cornerRadius(25)
                    
                    Spacer()
                    
                    Text(duration)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(color)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(color.opacity(0.1))
                        .cornerRadius(12)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(Color("TextPrimary"))
                    
                    Text(subtitle)
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                }
                
                Spacer()
                
                HStack {
                    Image(systemName: "play.fill")
                        .font(.system(size: 14, weight: .bold))
                    Text("Başla")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(color)
                .cornerRadius(20)
            }
            .padding(16)
            .frame(height: 180)
            .background(Color("CardBackground"))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        }
    }
}

struct RecommendedSessionCard: View {
    let session: PracticeSession
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(session.title)
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(Color("TextPrimary"))
                        
                        Text(session.description)
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(Color("TextSecondary"))
                            .lineLimit(2)
                    }
                    
                    Spacer()
                    
                    Text("\(session.duration) dk")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(Color("PrimaryColor"))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color("PrimaryColor").opacity(0.1))
                        .cornerRadius(12)
                }
                
                HStack {
                    Text(session.category.rawValue)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color("CardBackground"))
                        .cornerRadius(12)
                    
                    Spacer()
                    
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(Color("PrimaryColor"))
                }
            }
            .padding(16)
            .frame(width: 250)
            .background(Color("CardBackground"))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        }
    }
}

struct PracticeSessionCard: View {
    let session: PracticeSession
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(session.title)
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(Color("TextPrimary"))
                        
                        Text(session.description)
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(Color("TextSecondary"))
                            .lineLimit(2)
                    }
                    
                    Spacer()
                    
                    Text("\(session.duration) dk")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(Color("PrimaryColor"))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color("PrimaryColor").opacity(0.1))
                        .cornerRadius(12)
                }
                
                HStack {
                    Text(session.category.rawValue)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color("CardBackground"))
                        .cornerRadius(12)
                    
                    Text(session.level.rawValue)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color("CardBackground"))
                        .cornerRadius(12)
                    
                    Spacer()
                    
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(Color("PrimaryColor"))
                }
            }
            .padding(16)
            .background(Color("CardBackground"))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        }
    }
}

struct RecentSessionRow: View {
    let session: PracticeSession
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: "clock.arrow.circlepath")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Color("PrimaryColor"))
                    .frame(width: 40, height: 40)
                    .background(Color("PrimaryColor").opacity(0.1))
                    .cornerRadius(20)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(session.title)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("TextPrimary"))
                    
                    Text(session.description)
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(session.duration) dk")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(Color("PrimaryColor"))
                    
                    Text(session.category.rawValue)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                }
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color("TextSecondary"))
            }
            .padding(16)
            .background(Color("CardBackground"))
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        }
    }
}

#Preview {
    PracticeView()
}
