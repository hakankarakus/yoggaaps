//
//  ExploreView.swift
//  yoggapps
//  Explore Different Yoga Types and Categories
//  Created by Hakan Karakuş on 10.08.2025.
//

import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""
    @State private var selectedCategory: YogaCategory = .all
    @State private var selectedLevel: YogaLevel = .beginner
    @State private var showingFilters = false
    
    enum YogaCategory: String, CaseIterable {
        case all = "Tümü"
        case hatha = "Hatha"
        case vinyasa = "Vinyasa"
        case yin = "Yin"
        case restorative = "Restoratif"
        case chair = "Sandalye"
        case office = "Ofis"
        case morning = "Sabah"
        case evening = "Akşam"
        case stress = "Stres Azaltma"
        case energy = "Enerji Artırma"
        case flexibility = "Esneklik"
        case strength = "Güç"
        case balance = "Denge"
        case meditation = "Meditasyon"
    }
    
    enum YogaLevel: String, CaseIterable {
        case beginner = "Başlangıç"
        case intermediate = "Orta"
        case advanced = "İleri"
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search and Filter Header
                searchAndFilterHeader
                
                // Category Pills
                categoryPills
                
                // Content
                ScrollView {
                    LazyVStack(spacing: 24) {
                        // Featured Section
                        featuredSection
                        
                        // Level-based Sections
                        levelSection(title: "Başlangıç Seviyesi", level: .beginner)
                        levelSection(title: "Orta Seviye", level: .intermediate)
                        levelSection(title: "İleri Seviye", level: .advanced)
                        
                        // Special Collections
                        specialCollectionsSection
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                }
            }
            .background(Color("BackgroundColor"))
            .navigationBarHidden(true)
            .sheet(isPresented: $showingFilters) {
                FilterView(selectedCategory: $selectedCategory, selectedLevel: $selectedLevel)
            }
        }
    }
    
    private var searchAndFilterHeader: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Keşfet")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(Color("TextPrimary"))
                
                Spacer()
                
                Button(action: {
                    showingFilters = true
                }) {
                    Image(systemName: "slider.horizontal.3")
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
                
                TextField("Yoga türü, seviye veya süre ara...", text: $searchText)
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
    
    private var categoryPills: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(YogaCategory.allCases, id: \.self) { category in
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
    
    private var featuredSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Öne Çıkanlar")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    FeaturedCard(
                        title: "Günün Yogası",
                        subtitle: "Sabah Enerjisi",
                        duration: "15 dk",
                        imageName: "sunrise.fill",
                        color: Color("AccentColor")
                    )
                    
                    FeaturedCard(
                        title: "Stres Azaltma",
                        subtitle: "Hızlı Rahatlama",
                        duration: "10 dk",
                        imageName: "leaf.fill",
                        color: Color("TertiaryColor")
                    )
                    
                    FeaturedCard(
                        title: "Ofis Egzersizi",
                        subtitle: "Sandalye Yogası",
                        duration: "8 dk",
                        imageName: "chair.fill",
                        color: Color("SecondaryColor")
                    )
                }
                .padding(.horizontal, 20)
            }
        }
    }
    
    private func levelSection(title: String, level: YogaLevel) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                ForEach(getYogaTypes(for: level), id: \.title) { yogaType in
                    YogaTypeCard(
                        title: yogaType.title,
                        duration: yogaType.duration,
                        location: yogaType.location,
                        benefits: yogaType.benefits,
                        icon: yogaType.icon,
                        color: yogaType.color
                    )
                }
            }
        }
    }
    
    private var specialCollectionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Özel Koleksiyonlar")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            VStack(spacing: 12) {
                CollectionRow(
                    title: "7 Günlük Başlangıç Serisi",
                    subtitle: "Yogaya yeni başlayanlar için",
                    duration: "7 gün",
                    icon: "calendar",
                    color: Color("PrimaryColor")
                )
                
                CollectionRow(
                    title: "Stres Yönetimi Serisi",
                    subtitle: "Günlük stresi azaltmak için",
                    duration: "21 gün",
                    icon: "heart.fill",
                    color: Color("TertiaryColor")
                )
                
                CollectionRow(
                    title: "Esneklik Artırma",
                    subtitle: "Vücut esnekliğini geliştirmek için",
                    duration: "30 gün",
                    icon: "figure.flexibility",
                    color: Color("SecondaryColor")
                )
            }
        }
    }
    
    private func getYogaTypes(for level: YogaLevel) -> [YogaTypeData] {
        switch level {
        case .beginner:
            return [
                YogaTypeData(title: "Temel Duruşlar", duration: "10-15 dk", location: "Evde", benefits: "Temel yoga pozları ve nefes teknikleri", icon: "figure.walk", color: Color("PrimaryColor")),
                YogaTypeData(title: "Sandalye Yogası", duration: "8-12 dk", location: "Ofiste", benefits: "İş yerinde hızlı rahatlama", icon: "chair.fill", color: Color("SecondaryColor")),
                YogaTypeData(title: "Sabah Ritüeli", duration: "15 dk", location: "Evde", benefits: "Güne enerjik başlangıç", icon: "sunrise.fill", color: Color("AccentColor")),
                YogaTypeData(title: "Gece Rahatlama", duration: "10 dk", location: "Yatakta", benefits: "Uyku öncesi rahatlama", icon: "moon.fill", color: Color("TertiaryColor"))
            ]
        case .intermediate:
            return [
                YogaTypeData(title: "Vinyasa Flow", duration: "20-30 dk", location: "Evde", benefits: "Dinamik yoga akışı", icon: "figure.yoga", color: Color("PrimaryColor")),
                YogaTypeData(title: "Güç Yogası", duration: "25-35 dk", location: "Spor salonu", benefits: "Kas gücü ve dayanıklılık", icon: "dumbbell.fill", color: Color("SecondaryColor")),
                YogaTypeData(title: "Denge Serisi", duration: "20 dk", location: "Evde", benefits: "Denge ve odaklanma", icon: "figure.balance", color: Color("AccentColor")),
                YogaTypeData(title: "Kalça Açma", duration: "18-25 dk", location: "Evde", benefits: "Kalça esnekliği ve rahatlama", icon: "figure.flexibility", color: Color("TertiaryColor"))
            ]
        case .advanced:
            return [
                YogaTypeData(title: "Ashtanga Serisi", duration: "45-60 dk", location: "Stüdyo", benefits: "Geleneksel yoga serisi", icon: "figure.yoga", color: Color("PrimaryColor")),
                YogaTypeData(title: "İleri Denge", duration: "30-40 dk", location: "Evde", benefits: "Karmaşık denge pozları", icon: "figure.balance", color: Color("SecondaryColor")),
                YogaTypeData(title: "Meditasyon", duration: "20-30 dk", location: "Sessiz ortam", benefits: "Derin meditasyon ve farkındalık", icon: "brain.head.profile", color: Color("AccentColor")),
                YogaTypeData(title: "Pranayama", duration: "25-35 dk", location: "Sessiz ortam", benefits: "Nefes kontrolü teknikleri", icon: "lungs.fill", color: Color("TertiaryColor"))
            ]
        }
    }
}

struct YogaTypeData {
    let title: String
    let duration: String
    let location: String
    let benefits: String
    let icon: String
    let color: Color
}

struct FeaturedCard: View {
    let title: String
    let subtitle: String
    let duration: String
    let imageName: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: imageName)
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
        }
        .padding(16)
        .frame(width: 200)
        .background(Color("CardBackground"))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

struct CollectionRow: View {
    let title: String
    let subtitle: String
    let duration: String
    let icon: String
    let color: Color
    
    var body: some View {
        Button(action: {
            // Navigate to collection
        }) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(color)
                    .frame(width: 50, height: 50)
                    .background(color.opacity(0.1))
                    .cornerRadius(25)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("TextPrimary"))
                    
                    Text(subtitle)
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(duration)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(color)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(color.opacity(0.1))
                        .cornerRadius(12)
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color("TextSecondary"))
                }
            }
            .padding(16)
            .background(Color("CardBackground"))
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        }
    }
}

struct FilterView: View {
    @Binding var selectedCategory: ExploreView.YogaCategory
    @Binding var selectedLevel: ExploreView.YogaLevel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // Category Selection
                VStack(alignment: .leading, spacing: 16) {
                    Text("Kategori")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(Color("TextPrimary"))
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3), spacing: 12) {
                        ForEach(ExploreView.YogaCategory.allCases, id: \.self) { category in
                            Button(action: {
                                selectedCategory = category
                            }) {
                                Text(category.rawValue)
                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                    .foregroundColor(selectedCategory == category ? .white : Color("TextPrimary"))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(selectedCategory == category ? Color("PrimaryColor") : Color("CardBackground"))
                                    .cornerRadius(16)
                            }
                        }
                    }
                }
                
                // Level Selection
                VStack(alignment: .leading, spacing: 16) {
                    Text("Seviye")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(Color("TextPrimary"))
                    
                    HStack(spacing: 12) {
                        ForEach(ExploreView.YogaLevel.allCases, id: \.self) { level in
                            Button(action: {
                                selectedLevel = level
                            }) {
                                Text(level.rawValue)
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundColor(selectedLevel == level ? .white : Color("TextPrimary"))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(selectedLevel == level ? Color("PrimaryColor") : Color("CardBackground"))
                                    .cornerRadius(20)
                            }
                        }
                    }
                }
                
                Spacer()
                
                // Apply Button
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Uygula")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color("PrimaryColor"))
                        .cornerRadius(25)
                }
            }
            .padding(20)
            .background(Color("BackgroundColor"))
            .navigationTitle("Filtreler")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Kapat") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    ExploreView()
}
