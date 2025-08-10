//
//  ProfileView.swift
//  yoggapps
//  User Profile and Settings
//  Created by Hakan Karakuş on 10.08.2025.
//

import SwiftUI

struct ProfileView: View {
    @State private var showingEditProfile = false
    @State private var showingSettings = false
    @State private var showingNotifications = false
    @State private var showingPrivacy = false
    @State private var showingHelp = false
    @State private var showingAbout = false
    @State private var showingLogout = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Header
                    profileHeaderSection
                    
                    // Quick Stats
                    quickStatsSection
                    
                    // Profile Actions
                    profileActionsSection
                    
                    // App Settings
                    appSettingsSection
                    
                    // Support & Info
                    supportSection
                    
                    // Account Actions
                    accountActionsSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
            .background(Color("BackgroundColor"))
            .navigationBarHidden(true)
            .sheet(isPresented: $showingEditProfile) {
                EditProfileView()
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
            .sheet(isPresented: $showingNotifications) {
                NotificationSettingsView()
            }
            .sheet(isPresented: $showingPrivacy) {
                PrivacySettingsView()
            }
            .sheet(isPresented: $showingHelp) {
                HelpView()
            }
            .sheet(isPresented: $showingAbout) {
                AboutView()
            }
            .alert("Çıkış Yap", isPresented: $showingLogout) {
                Button("İptal", role: .cancel) { }
                Button("Çıkış Yap", role: .destructive) {
                    // Handle logout
                }
            } message: {
                Text("Hesabından çıkış yapmak istediğinden emin misin?")
            }
        }
    }
    
    private var profileHeaderSection: some View {
        VStack(spacing: 20) {
            // Profile Picture and Name
            VStack(spacing: 16) {
                Button(action: {
                    showingEditProfile = true
                }) {
                    ZStack {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 80, weight: .light))
                            .foregroundColor(Color("PrimaryColor"))
                        
                        Image(systemName: "pencil.circle.fill")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(Color("PrimaryColor"))
                            .background(Color.white)
                            .clipShape(Circle())
                            .offset(x: 25, y: 25)
                    }
                }
                
                VStack(spacing: 8) {
                    Text("Hakan Karakuş")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(Color("TextPrimary"))
                    
                    Text("Yoga Öğrencisi")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                    
                    Text("Üye olma: Ocak 2025")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
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
                .foregroundColor(Color("PrimaryColor"))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color("PrimaryColor").opacity(0.1))
                .cornerRadius(25)
            }
        }
        .padding(24)
        .background(Color("CardBackground"))
        .cornerRadius(20)
    }
    
    private var quickStatsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Hızlı İstatistikler")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 16) {
                QuickStatCard(
                    title: "Seans",
                    value: "47",
                    icon: "play.circle.fill",
                    color: Color("PrimaryColor")
                )
                
                QuickStatCard(
                    title: "Saat",
                    value: "23.5",
                    icon: "clock.fill",
                    color: Color("AccentColor")
                )
                
                QuickStatCard(
                    title: "Seri",
                    value: "8",
                    icon: "flame.fill",
                    color: Color("TertiaryColor")
                )
            }
        }
    }
    
    private var profileActionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Profil")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            VStack(spacing: 12) {
                ProfileActionRow(
                    title: "Kişisel Bilgiler",
                    subtitle: "Ad, e-posta, doğum tarihi",
                    icon: "person.fill",
                    color: Color("PrimaryColor")
                ) {
                    showingEditProfile = true
                }
                
                ProfileActionRow(
                    title: "Hedefler",
                    subtitle: "Yoga hedeflerini yönet",
                    icon: "target",
                    color: Color("AccentColor")
                ) {
                    // Navigate to goals
                }
                
                ProfileActionRow(
                    title: "Favoriler",
                    subtitle: "Kaydedilen seanslar ve pozlar",
                    icon: "heart.fill",
                    color: Color("TertiaryColor")
                ) {
                    // Navigate to favorites
                }
                
                ProfileActionRow(
                    title: "Geçmiş",
                    subtitle: "Tamamlanan seanslar",
                    icon: "clock.arrow.circlepath",
                    color: Color("SecondaryColor")
                ) {
                    // Navigate to history
                }
            }
        }
    }
    
    private var appSettingsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Uygulama")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            VStack(spacing: 12) {
                ProfileActionRow(
                    title: "Bildirimler",
                    subtitle: "Hatırlatmalar ve bildirimler",
                    icon: "bell.fill",
                    color: Color("PrimaryColor")
                ) {
                    showingNotifications = true
                }
                
                ProfileActionRow(
                    title: "Gizlilik",
                    subtitle: "Veri kullanımı ve gizlilik",
                    icon: "lock.fill",
                    color: Color("AccentColor")
                ) {
                    showingPrivacy = true
                }
                
                ProfileActionRow(
                    title: "Genel Ayarlar",
                    subtitle: "Tema, dil ve diğer ayarlar",
                    icon: "gearshape.fill",
                    color: Color("TertiaryColor")
                ) {
                    showingSettings = true
                }
                
                ProfileActionRow(
                    title: "Veri Senkronizasyonu",
                    subtitle: "iCloud ve yedekleme",
                    icon: "icloud.fill",
                    color: Color("SecondaryColor")
                ) {
                    // Handle data sync
                }
            }
        }
    }
    
    private var supportSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Destek & Bilgi")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            VStack(spacing: 12) {
                ProfileActionRow(
                    title: "Yardım Merkezi",
                    subtitle: "SSS ve kullanım kılavuzu",
                    icon: "questionmark.circle.fill",
                    color: Color("PrimaryColor")
                ) {
                    showingHelp = true
                }
                
                ProfileActionRow(
                    title: "Hakkında",
                    subtitle: "Uygulama versiyonu ve lisans",
                    icon: "info.circle.fill",
                    color: Color("AccentColor")
                ) {
                    showingAbout = true
                }
                
                ProfileActionRow(
                    title: "Geri Bildirim",
                    subtitle: "Öneri ve hata bildirimi",
                    icon: "envelope.fill",
                    color: Color("TertiaryColor")
                ) {
                    // Handle feedback
                }
                
                ProfileActionRow(
                    title: "Değerlendir",
                    subtitle: "App Store'da değerlendir",
                    icon: "star.fill",
                    color: Color("SecondaryColor")
                ) {
                    // Handle app store rating
                }
            }
        }
    }
    
    private var accountActionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Hesap")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            VStack(spacing: 12) {
                ProfileActionRow(
                    title: "Şifre Değiştir",
                    subtitle: "Hesap güvenliği",
                    icon: "key.fill",
                    color: Color("PrimaryColor")
                ) {
                    // Handle password change
                }
                
                ProfileActionRow(
                    title: "Hesabı Sil",
                    subtitle: "Kalıcı olarak hesabı kaldır",
                    icon: "trash.fill",
                    color: Color.red
                ) {
                    // Handle account deletion
                }
                
                ProfileActionRow(
                    title: "Çıkış Yap",
                    subtitle: "Hesabından güvenli çıkış",
                    icon: "rectangle.portrait.and.arrow.right",
                    color: Color("TertiaryColor")
                ) {
                    showingLogout = true
                }
            }
        }
    }
}

struct QuickStatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(color)
                .frame(width: 50, height: 50)
                .background(color.opacity(0.1))
                .cornerRadius(25)
            
            VStack(spacing: 4) {
                Text(value)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(Color("TextPrimary"))
                
                Text(title)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(Color("TextSecondary"))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(Color("CardBackground"))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

struct ProfileActionRow: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(color)
                    .frame(width: 40, height: 40)
                    .background(color.opacity(0.1))
                    .cornerRadius(20)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("TextPrimary"))
                    
                    Text(subtitle)
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                }
                
                Spacer()
                
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

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var firstName = "Hakan"
    @State private var lastName = "Karakuş"
    @State private var email = "hakan@example.com"
    @State private var birthDate = Date()
    @State private var selectedGender = "Belirtmek İstemiyorum"
    @State private var selectedLevel = "Başlangıç"
    
    let genderOptions = ["Belirtmek İstemiyorum", "Kadın", "Erkek", "Diğer"]
    let levelOptions = ["Başlangıç", "Orta", "İleri"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Picture
                    VStack(spacing: 16) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 80, weight: .light))
                            .foregroundColor(Color("PrimaryColor"))
                        
                        Button("Fotoğraf Değiştir") {
                            // Handle photo change
                        }
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color("PrimaryColor"))
                    }
                    
                    // Form Fields
                    VStack(spacing: 20) {
                        FormField(title: "Ad", text: $firstName)
                        FormField(title: "Soyad", text: $lastName)
                        FormField(title: "E-posta", text: $email)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Doğum Tarihi")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("TextPrimary"))
                            
                            DatePicker("", selection: $birthDate, displayedComponents: .date)
                                .datePickerStyle(CompactDatePickerStyle())
                                .labelsHidden()
                        }
                        
                        FormPicker(title: "Cinsiyet", selection: $selectedGender, options: genderOptions)
                        FormPicker(title: "Yoga Seviyesi", selection: $selectedLevel, options: levelOptions)
                    }
                }
                .padding(20)
            }
            .background(Color("BackgroundColor"))
            .navigationTitle("Profili Düzenle")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("İptal") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Kaydet") {
                    // Save profile changes
                    presentationMode.wrappedValue.dismiss()
                }
                .fontWeight(.semibold)
            )
        }
    }
}

struct FormField: View {
    let title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            TextField(title, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.system(size: 16, weight: .medium, design: .rounded))
        }
    }
}

struct FormPicker: View {
    let title: String
    @Binding var selection: String
    let options: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            Picker(title, selection: $selection) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color("CardBackground"))
            .cornerRadius(8)
        }
    }
}

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isDarkMode = false
    @State private var selectedLanguage = "Türkçe"
    @State private var isHapticFeedback = true
    @State private var isSoundEnabled = true
    
    let languageOptions = ["Türkçe", "English", "Deutsch", "Français"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Görünüm")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(Color("TextPrimary"))
                        
                        Toggle("Karanlık Mod", isOn: $isDarkMode)
                            .toggleStyle(SwitchToggleStyle(tint: Color("PrimaryColor")))
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Genel")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(Color("TextPrimary"))
                        
                        FormPicker(title: "Dil", selection: $selectedLanguage, options: languageOptions)
                        Toggle("Dokunsal Geri Bildirim", isOn: $isHapticFeedback)
                            .toggleStyle(SwitchToggleStyle(tint: Color("PrimaryColor")))
                        Toggle("Ses Efektleri", isOn: $isSoundEnabled)
                            .toggleStyle(SwitchToggleStyle(tint: Color("PrimaryColor")))
                    }
                }
                .padding(20)
            }
            .background(Color("BackgroundColor"))
            .navigationTitle("Ayarlar")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Kapat") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct NotificationSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isDailyReminder = true
    @State private var reminderTime = Date()
    @State private var isWeeklyReport = true
    @State private var isAchievementNotifications = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Günlük Hatırlatıcı")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(Color("TextPrimary"))
                        
                        Toggle("Günlük Hatırlatıcı", isOn: $isDailyReminder)
                            .toggleStyle(SwitchToggleStyle(tint: Color("PrimaryColor")))
                        
                        if isDailyReminder {
                            DatePicker("Hatırlatma Zamanı", selection: $reminderTime, displayedComponents: .hourAndMinute)
                                .datePickerStyle(CompactDatePickerStyle())
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Diğer Bildirimler")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(Color("TextPrimary"))
                        
                        Toggle("Haftalık Rapor", isOn: $isWeeklyReport)
                            .toggleStyle(SwitchToggleStyle(tint: Color("PrimaryColor")))
                        Toggle("Başarı Bildirimleri", isOn: $isAchievementNotifications)
                            .toggleStyle(SwitchToggleStyle(tint: Color("PrimaryColor")))
                    }
                }
                .padding(20)
            }
            .background(Color("BackgroundColor"))
            .navigationTitle("Bildirimler")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Kapat") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct PrivacySettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isDataCollection = true
    @State private var isAnalytics = false
    @State private var isCrashReports = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Veri Kullanımı")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(Color("TextPrimary"))
                        
                        Toggle("Veri Toplama", isOn: $isDataCollection)
                            .toggleStyle(SwitchToggleStyle(tint: Color("PrimaryColor")))
                        Toggle("Analitik", isOn: $isAnalytics)
                            .toggleStyle(SwitchToggleStyle(tint: Color("PrimaryColor")))
                        Toggle("Çökme Raporları", isOn: $isCrashReports)
                            .toggleStyle(SwitchToggleStyle(tint: Color("PrimaryColor")))
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Gizlilik Politikası")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(Color("TextPrimary"))
                        
                        Text("Verileriniz nasıl toplandığı ve kullanıldığı hakkında detaylı bilgi için gizlilik politikamızı okuyabilirsiniz.")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(Color("TextSecondary"))
                    }
                }
                .padding(20)
            }
            .background(Color("BackgroundColor"))
            .navigationTitle("Gizlilik")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Kapat") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct HelpView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    Text("Yardım Merkezi")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(Color("TextPrimary"))
                    
                    Text("Bu sayfa geliştirilme aşamasında...")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                }
                .padding(20)
            }
            .background(Color("BackgroundColor"))
            .navigationTitle("Yardım")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Kapat") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AboutView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 80, weight: .light))
                        .foregroundColor(Color("PrimaryColor"))
                    
                    VStack(spacing: 16) {
                        Text("YoggApps")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(Color("TextPrimary"))
                        
                        Text("Versiyon 1.0.0")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(Color("TextSecondary"))
                        
                        Text("Yoga ve mindfulness için geliştirilmiş kişisel uygulama")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(Color("TextSecondary"))
                            .multilineTextAlignment(.center)
                    }
                    
                    VStack(spacing: 12) {
                        Text("© 2025 YoggApps. Tüm hakları saklıdır.")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(Color("TextSecondary"))
                        
                        Text("Geliştirici: Hakan Karakuş")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(Color("TextSecondary"))
                    }
                }
                .padding(20)
            }
            .background(Color("BackgroundColor"))
            .navigationTitle("Hakkında")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Kapat") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    ProfileView()
}
