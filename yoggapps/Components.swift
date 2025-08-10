//
//  Components.swift
//  yoggapps
//  Reusable UI Components for Yoga App
//  Created by Hakan Karakuş on 10.08.2025.
//

import SwiftUI

// MARK: - Daily Guide Card
struct DailyGuideCard: View {
    let title: String
    let duration: String
    let location: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(Color("TextPrimary"))
                    
                    Text(description)
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                        .lineLimit(2)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(duration)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(Color("PrimaryColor"))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color("PrimaryColor").opacity(0.1))
                        .cornerRadius(20)
                    
                    Text(location)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                }
            }
            
            Button(action: {
                // Start practice action
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
                .background(Color("PrimaryColor"))
                .cornerRadius(25)
            }
        }
        .padding(20)
        .background(Color("CardBackground"))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

// MARK: - Quick Action Button
struct QuickActionButton: View {
    let title: String
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 32, weight: .medium))
                    .foregroundColor(Color("PrimaryColor"))
                
                Text(title)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(Color("TextPrimary"))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(Color("CardBackground"))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        }
    }
}

// MARK: - Yoga Type Card
struct YogaTypeCard: View {
    let title: String
    let duration: String
    let location: String
    let benefits: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(color)
                    .frame(width: 50, height: 50)
                    .background(color.opacity(0.1))
                    .cornerRadius(25)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(Color("TextPrimary"))
                    
                    Text(location)
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                }
                
                Spacer()
                
                Text(duration)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(color)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(color.opacity(0.1))
                    .cornerRadius(20)
            }
            
            Text(benefits)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(Color("TextSecondary"))
                .lineLimit(2)
            
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

// MARK: - Practice Timer View
struct PracticeTimerView: View {
    let totalTime: Int
    let currentPose: String
    let nextPose: String
    @State private var timeRemaining: Int
    @State private var isActive = false
    
    init(totalTime: Int, currentPose: String, nextPose: String) {
        self.totalTime = totalTime
        self.currentPose = currentPose
        self.nextPose = nextPose
        self._timeRemaining = State(initialValue: totalTime)
    }
    
    var body: some View {
        VStack(spacing: 30) {
            // Timer Display
            VStack(spacing: 16) {
                Text("\(timeRemaining / 60):\(String(format: "%02d", timeRemaining % 60))")
                    .font(.system(size: 72, weight: .bold, design: .rounded))
                    .foregroundColor(Color("PrimaryColor"))
                
                Text("Kalan Süre")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(Color("TextSecondary"))
            }
            
            // Current Pose
            VStack(spacing: 12) {
                Text("Şu Anki Poz")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(Color("TextSecondary"))
                
                Text(currentPose)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(Color("TextPrimary"))
                    .multilineTextAlignment(.center)
            }
            
            // Next Pose Preview
            VStack(spacing: 12) {
                Text("Sonraki Poz")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(Color("TextSecondary"))
                
                Text(nextPose)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(Color("TextPrimary"))
                    .multilineTextAlignment(.center)
                    .opacity(0.7)
            }
            
            // Control Buttons
            HStack(spacing: 20) {
                Button(action: {
                    isActive.toggle()
                }) {
                    Image(systemName: isActive ? "pause.fill" : "play.fill")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(Color("PrimaryColor"))
                        .cornerRadius(30)
                }
                
                Button(action: {
                    // Skip pose
                }) {
                    Image(systemName: "forward.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color("TextSecondary"))
                        .frame(width: 50, height: 50)
                        .background(Color("CardBackground"))
                        .cornerRadius(25)
                }
                
                Button(action: {
                    // End practice
                }) {
                    Image(systemName: "stop.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color("TextSecondary"))
                        .frame(width: 50, height: 50)
                        .background(Color("CardBackground"))
                        .cornerRadius(25)
                }
            }
        }
        .padding(30)
        .background(Color("BackgroundColor"))
        .onAppear {
            startTimer()
        }
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if isActive && timeRemaining > 0 {
                timeRemaining -= 1
            } else if timeRemaining == 0 {
                timer.invalidate()
            }
        }
    }
}

// MARK: - Progress Chart
struct ProgressChart: View {
    let data: [Int]
    let labels: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Haftalık İlerleme")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(Color("TextPrimary"))
            
            HStack(alignment: .bottom, spacing: 8) {
                ForEach(Array(zip(data.indices, data)), id: \.0) { index, value in
                    VStack(spacing: 8) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color("PrimaryColor"))
                            .frame(width: 30, height: CGFloat(value) * 2)
                        
                        Text(labels[index])
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundColor(Color("TextSecondary"))
                    }
                }
            }
            .frame(height: 120)
        }
        .padding(20)
        .background(Color("CardBackground"))
        .cornerRadius(20)
    }
}

// MARK: - Settings Row
struct SettingsRow: View {
    let title: String
    let subtitle: String?
    let icon: String
    let action: () -> Void
    
    init(title: String, subtitle: String? = nil, icon: String, action: @escaping () -> Void) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Color("PrimaryColor"))
                    .frame(width: 40, height: 40)
                    .background(Color("PrimaryColor").opacity(0.1))
                    .cornerRadius(20)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("TextPrimary"))
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(Color("TextSecondary"))
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color("TextSecondary"))
            }
            .padding(.vertical, 12)
        }
    }
}

// MARK: - Notification Reminder Card
struct NotificationReminderCard: View {
    let title: String
    let time: String
    let icon: String
    let color: Color
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
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
                    
                    Text(time)
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                }
                
                Spacer()
                
                Image(systemName: isEnabled ? "bell.fill" : "bell.slash.fill")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(isEnabled ? color : Color("TextSecondary"))
            }
            .padding(16)
            .background(Color("CardBackground"))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isEnabled ? color.opacity(0.3) : Color.clear, lineWidth: 1)
            )
        }
    }
}

// MARK: - Breathing Exercise View
struct BreathingExerciseView: View {
    @State private var breathingPhase = "Nefes Al"
    @State private var timeRemaining = 4
    @State private var isActive = false
    @State private var cycleCount = 0
    
    let totalCycles = 5
    
    var body: some View {
        VStack(spacing: 30) {
            // Breathing Circle
            ZStack {
                Circle()
                    .stroke(Color("PrimaryColor").opacity(0.3), lineWidth: 8)
                    .frame(width: 200, height: 200)
                
                Circle()
                    .fill(Color("PrimaryColor"))
                    .frame(width: isActive ? 180 : 60, height: isActive ? 180 : 60)
                    .scaleEffect(isActive ? 1.0 : 0.3)
                    .animation(.easeInOut(duration: 4), value: isActive)
                
                VStack(spacing: 8) {
                    Text(breathingPhase)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("\(timeRemaining)")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
            }
            
            // Instructions
            VStack(spacing: 16) {
                Text("Döngü \(cycleCount + 1)/\(totalCycles)")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(Color("TextSecondary"))
                
                Text("4 saniye nefes al, 4 saniye nefes ver")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(Color("TextSecondary"))
                    .multilineTextAlignment(.center)
            }
            
            // Control Button
            Button(action: {
                if !isActive {
                    startBreathing()
                } else {
                    stopBreathing()
                }
            }) {
                HStack {
                    Image(systemName: isActive ? "stop.fill" : "play.fill")
                        .font(.system(size: 18, weight: .bold))
                    Text(isActive ? "Durdur" : "Başla")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color("PrimaryColor"))
                .cornerRadius(25)
            }
        }
        .padding(30)
        .background(Color("BackgroundColor"))
    }
    
    private func startBreathing() {
        isActive = true
        cycleCount = 0
        breathingPhase = "Nefes Al"
        timeRemaining = 4
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                if breathingPhase == "Nefes Al" {
                    breathingPhase = "Nefes Ver"
                    timeRemaining = 4
                } else {
                    breathingPhase = "Nefes Al"
                    timeRemaining = 4
                    cycleCount += 1
                    
                    if cycleCount >= totalCycles {
                        timer.invalidate()
                        isActive = false
                        breathingPhase = "Tamamlandı!"
                    }
                }
            }
        }
    }
    
    private func stopBreathing() {
        isActive = false
        breathingPhase = "Nefes Al"
        timeRemaining = 4
        cycleCount = 0
    }
}

// MARK: - Quick Stats Card
struct QuickStatsCard: View {
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

#Preview {
    VStack(spacing: 20) {
        DailyGuideCard(
            title: "Ofis Sandalye Yogası",
            duration: "6 dk",
            location: "Ofiste",
            description: "Toplantı arası hızlı rahatlama"
        )
        
        QuickActionButton(title: "Hemen Yoga Yap", icon: "play.circle.fill")
        
        YogaTypeCard(
            title: "Chair Yoga",
            duration: "5-10 dk",
            location: "Ofiste, toplantı arası",
            benefits: "Bel-boyun rahatlaması, duruş düzeltme",
            icon: "chair.fill",
            color: Color("PrimaryColor")
        )
        
        NotificationReminderCard(
            title: "Sabah Hatırlatıcısı",
            time: "08:00",
            icon: "sunrise.fill",
            color: Color("AccentColor"),
            isEnabled: true
        ) {}
        
        QuickStatsCard(
            title: "Haftalık Seans",
            value: "5",
            change: "+2",
            isPositive: true,
            icon: "play.circle.fill",
            color: Color("PrimaryColor")
        )
    }
    .padding()
    .background(Color("BackgroundColor"))
}
