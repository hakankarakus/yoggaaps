//
//  NotificationManager.swift
//  yoggapps
//  Local Notification Management for Yoga App
//  Created by Hakan Karakuş on 10.08.2025.
//

import Foundation
import UserNotifications
import SwiftUI

class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    
    @Published var isAuthorized = false
    @Published var morningReminder = true
    @Published var afternoonReminder = true
    @Published var eveningReminder = false
    @Published var weeklyProgress = true
    
    private init() {
        checkAuthorizationStatus()
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            DispatchQueue.main.async {
                self.isAuthorized = granted
                if granted {
                    self.scheduleNotifications()
                }
            }
            
            if let error = error {
                print("Notification authorization error: \(error)")
            }
        }
    }
    
    func checkAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.isAuthorized = settings.authorizationStatus == .authorized
            }
        }
    }
    
    func scheduleNotifications() {
        guard isAuthorized else { return }
        
        // Remove existing notifications
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        // Schedule morning reminder
        if morningReminder {
            scheduleNotification(
                title: "Sabah Yogası",
                body: "Güne huzurla başla! 5 dakikalık sabah yogası yap.",
                hour: 8,
                minute: 0,
                identifier: "morning_reminder"
            )
        }
        
        // Schedule afternoon reminder
        if afternoonReminder {
            scheduleNotification(
                title: "Öğle Molası",
                body: "Gün ortası rahatlama zamanı! Hızlı ofis yogası yap.",
                hour: 13,
                minute: 0,
                identifier: "afternoon_reminder"
            )
        }
        
        // Schedule evening reminder
        if eveningReminder {
            scheduleNotification(
                title: "Akşam Rahatlaması",
                body: "Günü huzurla kapat! Uyku öncesi esneme yap.",
                hour: 21,
                minute: 0,
                identifier: "evening_reminder"
            )
        }
        
        // Schedule weekly progress reminder
        if weeklyProgress {
            scheduleWeeklyNotification(
                title: "Haftalık İlerleme",
                body: "Bu haftaki yoga hedeflerini kontrol et!",
                weekday: 1, // Monday
                hour: 10,
                minute: 0,
                identifier: "weekly_progress"
            )
        }
    }
    
    private func scheduleNotification(title: String, body: String, hour: Int, minute: Int, identifier: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        content.badge = 1
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    private func scheduleWeeklyNotification(title: String, body: String, weekday: Int, hour: Int, minute: Int, identifier: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        content.badge = 1
        
        var dateComponents = DateComponents()
        dateComponents.weekday = weekday
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling weekly notification: \(error)")
            }
        }
    }
    
    func schedulePracticeReminder(title: String, body: String, timeInterval: TimeInterval) {
        guard isAuthorized else { return }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: "practice_reminder_\(Date().timeIntervalSince1970)", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling practice reminder: \(error)")
            }
        }
    }
    
    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func cancelNotification(withIdentifier identifier: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}

// MARK: - Notification Settings View
struct NotificationSettingsView: View {
    @StateObject private var notificationManager = NotificationManager.shared
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                if !notificationManager.isAuthorized {
                    authorizationSection
                }
                
                notificationSettingsSection
                
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
    
    private var authorizationSection: some View {
        VStack(spacing: 16) {
            Image(systemName: "bell.slash.fill")
                .font(.system(size: 60, weight: .medium))
                .foregroundColor(Color("TextSecondary"))
                .frame(width: 100, height: 100)
                .background(Color("TextSecondary").opacity(0.1))
                .cornerRadius(50)
            
            VStack(spacing: 8) {
                Text("Bildirimler Kapalı")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(Color("TextPrimary"))
                
                Text("Yoga hatırlatıcıları almak için bildirimlere izin ver")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(Color("TextSecondary"))
                    .multilineTextAlignment(.center)
            }
            
            Button(action: {
                notificationManager.requestAuthorization()
            }) {
                Text("İzin Ver")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color("PrimaryColor"))
                    .cornerRadius(25)
            }
        }
        .padding(24)
        .background(Color("CardBackground"))
        .cornerRadius(20)
    }
    
    private var notificationSettingsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Hatırlatıcılar")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            VStack(spacing: 16) {
                NotificationReminderCard(
                    title: "Sabah Hatırlatıcısı",
                    time: "08:00",
                    icon: "sunrise.fill",
                    color: Color("AccentColor"),
                    isEnabled: notificationManager.morningReminder
                ) {
                    notificationManager.morningReminder.toggle()
                    notificationManager.scheduleNotifications()
                }
                
                NotificationReminderCard(
                    title: "Öğle Hatırlatıcısı",
                    time: "13:00",
                    icon: "clock.fill",
                    color: Color("PrimaryColor"),
                    isEnabled: notificationManager.afternoonReminder
                ) {
                    notificationManager.afternoonReminder.toggle()
                    notificationManager.scheduleNotifications()
                }
                
                NotificationReminderCard(
                    title: "Akşam Hatırlatıcısı",
                    time: "21:00",
                    icon: "moon.fill",
                    color: Color("SecondaryColor"),
                    isEnabled: notificationManager.eveningReminder
                ) {
                    notificationManager.eveningReminder.toggle()
                    notificationManager.scheduleNotifications()
                }
                
                NotificationReminderCard(
                    title: "Haftalık İlerleme",
                    time: "Pazartesi 10:00",
                    icon: "chart.line.uptrend.xyaxis",
                    color: Color("TertiaryColor"),
                    isEnabled: notificationManager.weeklyProgress
                ) {
                    notificationManager.weeklyProgress.toggle()
                    notificationManager.scheduleNotifications()
                }
            }
        }
    }
}

#Preview {
    NotificationSettingsView()
}
