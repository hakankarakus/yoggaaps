//
//  ProfileView.swift
//  yoggapps
//  User Profile and Settings
//  Created by Hakan Karakuş on 10.08.2025.
//

import SwiftUI

struct ProfileView: View {
    @State private var userName = "Yoga Dostu"
    @State private var userEmail = "yoga@example.com"
    @State private var showingEditProfile = false
    @State private var showingNotifications = false
    @State private var showingPrivacy = false
    @State private var showingAbout = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Header
                    profileHeaderSection
                    
                    // Quick Stats
                    quickStatsSection
                    
                    // Settings
                    settingsSection
                    
                    // App Info
                    appInfoSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
            .background(Color("BackgroundColor"))
            .navigationTitle("Profil")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showingEditProfile) {
                EditProfileView(userName: $userName, userEmail: $userEmail)
            }
            .sheet(isPresented: $showingNotifications) {
                NotificationsSettingsView()
            }
            .sheet(isPresented: $showingPrivacy) {
                PrivacySettingsView()
            }
            .sheet(isPresented: $showingAbout) {
                AboutView()
            }
        }
    }
    
    private var profileHeaderSection: some View {
        VStack(spacing: 20) {
            // Profile Image
            VStack(spacing: 16) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 80, weight: .medium))
                    .foregroundColor(Color("PrimaryColor"))
                    .frame(width: 100, height: 100)
                    .background(Color("PrimaryColor").opacity(0.1))
                    .cornerRadius(50)
                
                VStack(spacing: 8) {
                    Text(userName)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(Color("TextPrimary"))
                    
                    Text(userEmail)
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                }
            }
            
            // Edit Profile Button
            Button(action: {
                showingEditProfile = true
            }) {
                HStack {
                    Image(systemName: "pencil")
                        .font(.system(size: 16, weight: .medium))
                    Text("Profili Düzenle")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color("PrimaryColor"))
                .cornerRadius(25)
            }
        }
        .padding(24)
        .background(Color("CardBackground"))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
    
    private var quickStatsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Hızlı İstatistikler")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3), spacing: 12) {
                QuickStatCard(title: "Toplam Seans", value: "156", icon: "play.circle.fill")
                QuickStatCard(title: "Toplam Süre", value: "18.5s", icon: "clock.fill")
                QuickStatCard(title: "Başarı", value: "24", icon: "trophy.fill")
            }
        }
    }
    
    private var settingsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Ayarlar")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            VStack(spacing: 8) {
                SettingsRow(
                    title: "Bildirimler",
                    subtitle: "Hatırlatıcılar ve güncellemeler",
                    icon: "bell.fill"
                ) {
                    showingNotifications = true
                }
                
                SettingsRow(
                    title: "Gizlilik",
                    subtitle: "Veri kullanımı ve güvenlik",
                    icon: "lock.fill"
                ) {
                    showingPrivacy = true
                }
                
                SettingsRow(
                    title: "Hedefler",
                    subtitle: "Günlük ve haftalık hedefler",
                    icon: "target"
                ) {
                    // Show goals settings
                }
                
                SettingsRow(
                    title: "Tema",
                    subtitle: "Açık/Koyu tema seçimi",
                    icon: "paintbrush.fill"
                ) {
                    // Show theme settings
                }
                
                SettingsRow(
                    title: "Dil",
                    subtitle: "Türkçe",
                    icon: "globe"
                ) {
                    // Show language settings
                }
            }
        }
    }
    
    private var appInfoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Uygulama Hakkında")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            VStack(spacing: 8) {
                SettingsRow(
                    title: "Hakkında",
                    subtitle: "Versiyon 1.0.0",
                    icon: "info.circle.fill"
                ) {
                    showingAbout = true
                }
                
                SettingsRow(
                    title: "Yardım & Destek",
                    subtitle: "SSS ve iletişim",
                    icon: "questionmark.circle.fill"
                ) {
                    // Show help
                }
                
                SettingsRow(
                    title: "Geri Bildirim",
                    subtitle: "Uygulamayı değerlendir",
                    icon: "star.fill"
                ) {
                    // Show feedback
                }
            }
        }
    }
}

struct QuickStatCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(Color("PrimaryColor"))
                .frame(width: 50, height: 50)
                .background(Color("PrimaryColor").opacity(0.1))
                .cornerRadius(25)
            
            VStack(spacing: 4) {
                Text(value)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(Color("TextPrimary"))
                
                Text(title)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(Color("TextSecondary"))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color("CardBackground"))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

struct EditProfileView: View {
    @Binding var userName: String
    @Binding var userEmail: String
    @Environment(\.dismiss) private var dismiss
    
    @State private var tempName: String = ""
    @State private var tempEmail: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                VStack(spacing: 20) {
                    // Profile Image
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 80, weight: .medium))
                        .foregroundColor(Color("PrimaryColor"))
                        .frame(width: 100, height: 100)
                        .background(Color("PrimaryColor").opacity(0.1))
                        .cornerRadius(50)
                    
                    // Form Fields
                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Ad Soyad")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("TextPrimary"))
                            
                            TextField("Adınızı girin", text: $tempName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("E-posta")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("TextPrimary"))
                            
                            TextField("E-posta adresinizi girin", text: $tempEmail)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                        }
                    }
                }
                
                Spacer()
                
                // Save Button
                Button(action: {
                    userName = tempName
                    userEmail = tempEmail
                    dismiss()
                }) {
                    Text("Kaydet")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color("PrimaryColor"))
                        .cornerRadius(25)
                }
            }
            .padding(24)
            .background(Color("BackgroundColor"))
            .navigationTitle("Profili Düzenle")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("İptal") {
                        dismiss()
                    }
                    .foregroundColor(Color("TextSecondary"))
                }
            }
            .onAppear {
                tempName = userName
                tempEmail = userEmail
            }
        }
    }
}

struct NotificationsSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var morningReminder = true
    @State private var afternoonReminder = true
    @State private var eveningReminder = false
    @State private var weeklyProgress = true
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                VStack(spacing: 16) {
                    SettingsRow(
                        title: "Sabah Hatırlatıcısı",
                        subtitle: "Güne yoga ile başla",
                        icon: "sunrise.fill"
                    ) {
                        morningReminder.toggle()
                    }
                    .overlay(
                        Toggle("", isOn: $morningReminder)
                            .labelsHidden()
                    )
                    
                    SettingsRow(
                        title: "Öğle Hatırlatıcısı",
                        subtitle: "Gün ortası rahatlama",
                        icon: "clock.fill"
                    ) {
                        afternoonReminder.toggle()
                    }
                    .overlay(
                        Toggle("", isOn: $afternoonReminder)
                            .labelsHidden()
                    )
                    
                    SettingsRow(
                        title: "Akşam Hatırlatıcısı",
                        subtitle: "Uyku öncesi esneme",
                        icon: "moon.fill"
                    ) {
                        eveningReminder.toggle()
                    }
                    .overlay(
                        Toggle("", isOn: $eveningReminder)
                            .labelsHidden()
                    )
                    
                    SettingsRow(
                        title: "Haftalık İlerleme",
                        subtitle: "Haftalık özet raporu",
                        icon: "chart.line.uptrend.xyaxis"
                    ) {
                        weeklyProgress.toggle()
                    }
                    .overlay(
                        Toggle("", isOn: $weeklyProgress)
                            .labelsHidden()
                    )
                }
                
                Spacer()
            }
            .padding(24)
            .background(Color("BackgroundColor"))
            .navigationTitle("Bildirimler")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Tamam") {
                        dismiss()
                    }
                    .foregroundColor(Color("PrimaryColor"))
                }
            }
        }
    }
}

struct PrivacySettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var dataCollection = true
    @State private var analytics = true
    @State private var personalizedContent = true
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                VStack(spacing: 16) {
                    SettingsRow(
                        title: "Veri Toplama",
                        subtitle: "Kullanım verilerini topla",
                        icon: "chart.bar.fill"
                    ) {
                        dataCollection.toggle()
                    }
                    .overlay(
                        Toggle("", isOn: $dataCollection)
                            .labelsHidden()
                    )
                    
                    SettingsRow(
                        title: "Analitik",
                        subtitle: "Uygulama performansı",
                        icon: "chart.line.uptrend.xyaxis"
                    ) {
                        analytics.toggle()
                    }
                    .overlay(
                        Toggle("", isOn: $analytics)
                            .labelsHidden()
                    )
                    
                    SettingsRow(
                        title: "Kişiselleştirilmiş İçerik",
                        subtitle: "Hedeflerine göre öneriler",
                        icon: "person.fill"
                    ) {
                        personalizedContent.toggle()
                    }
                    .overlay(
                        Toggle("", isOn: $personalizedContent)
                            .labelsHidden()
                    )
                }
                
                Spacer()
            }
            .padding(24)
            .background(Color("BackgroundColor"))
            .navigationTitle("Gizlilik")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Tamam") {
                        dismiss()
                    }
                    .foregroundColor(Color("PrimaryColor"))
                }
            }
        }
    }
}

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // App Icon
                Image(systemName: "figure.mind.and.body")
                    .font(.system(size: 80, weight: .medium))
                    .foregroundColor(Color("PrimaryColor"))
                    .frame(width: 120, height: 120)
                    .background(Color("PrimaryColor").opacity(0.1))
                    .cornerRadius(60)
                
                VStack(spacing: 16) {
                    Text("YoggApps")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(Color("TextPrimary"))
                    
                    Text("Modern Yoga Uygulaması")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                    
                    Text("Versiyon 1.0.0")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                }
                
                VStack(spacing: 12) {
                    Text("Bu uygulama, yoğun iş hayatında olan kişiler için özel olarak tasarlanmıştır.")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                        .multilineTextAlignment(.center)
                        .lineLimit(4)
                    
                    Text("Kısa süreli, her ortamda yapılabilir yoga türleri ile günlük yaşamınıza huzur katın.")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                        .multilineTextAlignment(.center)
                        .lineLimit(4)
                }
                
                Spacer()
            }
            .padding(30)
            .background(Color("BackgroundColor"))
            .navigationTitle("Hakkında")
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
}

#Preview {
    ProfileView()
}
