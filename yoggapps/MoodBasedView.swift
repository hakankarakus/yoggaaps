//
//  MoodBasedView.swift
//  yoggapps
//  Mood-Based Yoga Recommendations
//  Created by Hakan Karakuş on 10.08.2025.
//

import SwiftUI

struct MoodBasedView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedMood: MoodType = .energetic
    @State private var showingRecommendations = false
    
    enum MoodType: String, CaseIterable {
        case energetic = "Enerjik"
        case stressed = "Stresli"
        case tired = "Yorgun"
        case anxious = "Endişeli"
        case focused = "Odaklanmış"
        case relaxed = "Rahat"
        
        var icon: String {
            switch self {
            case .energetic: return "bolt.fill"
            case .stressed: return "exclamationmark.triangle.fill"
            case .tired: return "bed.double.fill"
            case .anxious: return "heart.fill"
            case .focused: return "brain.head.profile"
            case .relaxed: return "leaf.fill"
            }
        }
        
        var color: Color {
            switch self {
            case .energetic: return Color("AccentColor")
            case .stressed: return Color("TertiaryColor")
            case .tired: return Color("SecondaryColor")
            case .anxious: return Color("TertiaryColor")
            case .focused: return Color("PrimaryColor")
            case .relaxed: return Color("SecondaryColor")
            }
        }
        
        var description: String {
            switch self {
            case .energetic: return "Güne dinamik başlangıç"
            case .stressed: return "Stres ve gerginlik azaltma"
            case .tired: return "Enerji ve canlılık artırma"
            case .anxious: return "Sakinleşme ve rahatlama"
            case .focused: return "Zihinsel netlik ve konsantrasyon"
            case .relaxed: return "Huzur ve denge koruma"
            }
        }
        
        var recommendations: [YogaRecommendation] {
            switch self {
            case .energetic:
                return [
                    YogaRecommendation(title: "Güneşe Selam", duration: "8-12 dk", intensity: "Orta", benefits: "Enerji artırma, esneklik"),
                    YogaRecommendation(title: "Vinyasa Flow", duration: "10-15 dk", intensity: "Yüksek", benefits: "Güç artırma, denge")
                ]
            case .stressed:
                return [
                    YogaRecommendation(title: "Nefes Çalışması", duration: "5-8 dk", intensity: "Düşük", benefits: "Stres azaltma, sakinleşme"),
                    YogaRecommendation(title: "Yin Yoga", duration: "12-15 dk", intensity: "Düşük", benefits: "Derin rahatlama, esneme")
                ]
            case .tired:
                return [
                    YogaRecommendation(title: "Sabah Uyanma", duration: "6-8 dk", intensity: "Düşük", benefits: "Enerji artırma, uyanıklık"),
                    YogaRecommendation(title: "Chair Yoga", duration: "8-10 dk", intensity: "Orta", benefits: "Hafif hareket, canlılık")
                ]
            case .anxious:
                return [
                    YogaRecommendation(title: "Meditasyon", duration: "5-10 dk", intensity: "Düşük", benefits: "Zihinsel sakinlik"),
                    YogaRecommendation(title: "Restorative Yoga", duration: "10-12 dk", intensity: "Düşük", benefits: "Güvenlik hissi, rahatlama")
                ]
            case .focused:
                return [
                    YogaRecommendation(title: "Odaklanma Yogası", duration: "8-10 dk", intensity: "Orta", benefits: "Zihinsel netlik, konsantrasyon"),
                    YogaRecommendation(title: "Balance Poses", duration: "6-8 dk", intensity: "Orta", benefits: "Denge, odaklanma")
                ]
            case .relaxed:
                return [
                    YogaRecommendation(title: "Gentle Flow", duration: "10-12 dk", intensity: "Düşük", benefits: "Hareket, esneklik"),
                    YogaRecommendation(title: "Evening Wind Down", duration: "8-10 dk", intensity: "Düşük", benefits: "Gün sonu rahatlama")
                ]
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                headerSection
                
                // Mood Selection
                moodSelectionSection
                
                // Recommendations Button
                recommendationsButton
                
                Spacer()
            }
            .background(Color("BackgroundColor"))
            .navigationTitle("Ruh Haline Göre")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Kapat") {
                        dismiss()
                    }
                    .foregroundColor(Color("TextSecondary"))
                }
            }
            .sheet(isPresented: $showingRecommendations) {
                MoodRecommendationsView(mood: selectedMood)
            }
        }
    }
    
    private var headerSection: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart.text.square.fill")
                .font(.system(size: 60, weight: .medium))
                .foregroundColor(Color("PrimaryColor"))
                .frame(width: 100, height: 100)
                .background(Color("PrimaryColor").opacity(0.1))
                .cornerRadius(50)
            
            VStack(spacing: 8) {
                Text("Bugün nasıl hissediyorsun?")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(Color("TextPrimary"))
                    .multilineTextAlignment(.center)
                
                Text("Ruh haline uygun yoga önerileri al")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(Color("TextSecondary"))
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.horizontal, 30)
        .padding(.top, 40)
    }
    
    private var moodSelectionSection: some View {
        VStack(spacing: 20) {
            Text("Ruh Halini Seç")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                ForEach(MoodType.allCases, id: \.self) { mood in
                    MoodCard(
                        mood: mood,
                        isSelected: selectedMood == mood
                    ) {
                        selectedMood = mood
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.top, 30)
    }
    
    private var recommendationsButton: some View {
        Button(action: {
            showingRecommendations = true
        }) {
            HStack {
                Image(systemName: "sparkles")
                    .font(.system(size: 18, weight: .bold))
                Text("Önerileri Gör")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(selectedMood.color)
            .cornerRadius(25)
        }
        .padding(.horizontal, 30)
        .padding(.top, 30)
        .disabled(false)
    }
}

struct MoodCard: View {
    let mood: MoodBasedView.MoodType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 16) {
                Image(systemName: mood.icon)
                    .font(.system(size: 32, weight: .medium))
                    .foregroundColor(isSelected ? .white : mood.color)
                    .frame(width: 60, height: 60)
                    .background(isSelected ? mood.color : mood.color.opacity(0.1))
                    .cornerRadius(30)
                
                VStack(spacing: 8) {
                    Text(mood.rawValue)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(isSelected ? .white : Color("TextPrimary"))
                        .multilineTextAlignment(.center)
                    
                    Text(mood.description)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(isSelected ? .white.opacity(0.8) : Color("TextSecondary"))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(isSelected ? mood.color : Color("CardBackground"))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSelected ? Color.clear : mood.color.opacity(0.3), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        }
    }
}

struct YogaRecommendation {
    let title: String
    let duration: String
    let intensity: String
    let benefits: String
}

struct MoodRecommendationsView: View {
    let mood: MoodBasedView.MoodType
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Mood Header
                    moodHeaderSection
                    
                    // Recommendations
                    recommendationsSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
            .background(Color("BackgroundColor"))
            .navigationTitle("Öneriler")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Kapat") {
                        dismiss()
                    }
                    .foregroundColor(Color("TextSecondary"))
                }
            }
        }
    }
    
    private var moodHeaderSection: some View {
        VStack(spacing: 16) {
            Image(systemName: mood.icon)
                .font(.system(size: 60, weight: .medium))
                .foregroundColor(mood.color)
                .frame(width: 100, height: 100)
                .background(mood.color.opacity(0.1))
                .cornerRadius(50)
            
            VStack(spacing: 8) {
                Text(mood.rawValue)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(Color("TextPrimary"))
                
                Text(mood.description)
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(Color("TextSecondary"))
                    .multilineTextAlignment(.center)
            }
        }
        .padding(24)
        .background(Color("CardBackground"))
        .cornerRadius(20)
    }
    
    private var recommendationsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Önerilen Pratikler")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            VStack(spacing: 12) {
                ForEach(mood.recommendations, id: \.title) { recommendation in
                    RecommendationCard(recommendation: recommendation, color: mood.color)
                }
            }
        }
    }
}

struct RecommendationCard: View {
    let recommendation: YogaRecommendation
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(recommendation.title)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(Color("TextPrimary"))
                    
                    Text(recommendation.benefits)
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                        .lineLimit(2)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(recommendation.duration)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(color)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(color.opacity(0.1))
                        .cornerRadius(20)
                    
                    Text(recommendation.intensity)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                }
            }
            
            Button(action: {
                // Start practice
            }) {
                HStack {
                    Image(systemName: "play.fill")
                        .font(.system(size: 14, weight: .bold))
                    Text("Başla")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(color)
                .cornerRadius(25)
            }
        }
        .padding(20)
        .background(Color("CardBackground"))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    MoodBasedView()
}
