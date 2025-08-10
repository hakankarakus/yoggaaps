//
//  PracticeSessionView.swift
//  yoggapps
//  Active Yoga Practice Session View
//  Created by Hakan Karakuş on 10.08.2025.
//

import SwiftUI

struct PracticeSessionView: View {
    let session: PracticeSession
    @Environment(\.dismiss) private var dismiss
    @State private var currentPoseIndex = 0
    @State private var timeRemaining = 0
    @State private var isActive = false
    @State private var showingPauseMenu = false
    
    private var currentPose: String {
        guard currentPoseIndex < session.poses.count else { return "" }
        return session.poses[currentPoseIndex]
    }
    
    private var nextPoseName: String {
        let nextIndex = currentPoseIndex + 1
        guard nextIndex < session.poses.count else { return "" }
        return session.poses[nextIndex]
    }
    
    private var progress: Double {
        Double(currentPoseIndex) / Double(session.poses.count)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Progress Bar
                progressBar
                
                // Main Content
                VStack(spacing: 30) {
                    // Session Info
                    sessionInfoSection
                    
                    // Timer and Current Pose
                    timerSection
                    
                    // Next Pose Preview
                    nextPoseSection
                    
                    // Control Buttons
                    controlButtonsSection
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 40)
                
                Spacer()
            }
            .background(Color("BackgroundColor"))
            .navigationTitle(session.title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Bitir") {
                        dismiss()
                    }
                    .foregroundColor(Color("TextSecondary"))
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingPauseMenu = true
                    }) {
                        Image(systemName: "pause.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(Color("PrimaryColor"))
                    }
                }
            }
            .onAppear {
                startSession()
            }
            .actionSheet(isPresented: $showingPauseMenu) {
                ActionSheet(
                    title: Text("Seans Duraklatıldı"),
                    message: Text("Ne yapmak istiyorsun?"),
                    buttons: [
                        .default(Text("Devam Et")) {
                            isActive = true
                        },
                        .default(Text("Pozu Atlayın")) {
                            nextPose()
                        },
                        .destructive(Text("Seansı Bitir")) {
                            dismiss()
                        },
                        .cancel(Text("İptal"))
                    ]
                )
            }
        }
    }
    
    private var progressBar: some View {
        VStack(spacing: 8) {
            HStack {
                Text("İlerleme")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(Color("TextSecondary"))
                
                Spacer()
                
                Text("\(currentPoseIndex + 1)/\(session.poses.count)")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(Color("TextSecondary"))
            }
            .padding(.horizontal, 20)
            
            SwiftUI.ProgressView(value: progress)
                .progressViewStyle(LinearProgressViewStyle(tint: Color("PrimaryColor")))
                .scaleEffect(x: 1, y: 2, anchor: .center)
                .padding(.horizontal, 20)
        }
        .padding(.vertical, 16)
        .background(Color("CardBackground"))
    }
    
    private var sessionInfoSection: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "figure.yoga")
                    .font(.system(size: 32, weight: .medium))
                    .foregroundColor(Color("PrimaryColor"))
                    .frame(width: 60, height: 60)
                    .background(Color("PrimaryColor").opacity(0.1))
                    .cornerRadius(30)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(session.title)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(Color("TextPrimary"))
                    
                    Text(session.category.rawValue)
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color("TextSecondary"))
                }
                
                Spacer()
            }
        }
    }
    
    private var timerSection: some View {
        VStack(spacing: 20) {
            // Timer Display
            VStack(spacing: 12) {
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
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(Color("TextPrimary"))
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
            }
        }
    }
    
    private var nextPoseSection: some View {
        VStack(spacing: 12) {
            Text("Sonraki Poz")
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(Color("TextSecondary"))
            
            if !nextPoseName.isEmpty {
                Text(nextPoseName)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(Color("TextPrimary"))
                    .multilineTextAlignment(.center)
                    .opacity(0.7)
                    .lineLimit(2)
            } else {
                Text("Seans Tamamlandı!")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(Color("PrimaryColor"))
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    private var controlButtonsSection: some View {
        HStack(spacing: 20) {
            // Play/Pause Button
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
            
            // Skip Button
            Button(action: {
                nextPose()
            }) {
                Image(systemName: "forward.fill")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color("TextSecondary"))
                    .frame(width: 50, height: 50)
                    .background(Color("CardBackground"))
                    .cornerRadius(25)
            }
            
            // Repeat Button
            Button(action: {
                repeatPose()
            }) {
                Image(systemName: "repeat")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color("TextSecondary"))
                    .frame(width: 50, height: 50)
                    .background(Color("CardBackground"))
                    .cornerRadius(25)
            }
        }
    }
    
    private func startSession() {
        timeRemaining = 60 // 1 minute per pose
        isActive = true
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if isActive && timeRemaining > 0 {
                timeRemaining -= 1
            } else if timeRemaining == 0 {
                timer.invalidate()
                nextPose()
            }
        }
    }
    
    private func nextPose() {
        if currentPoseIndex < session.poses.count - 1 {
            currentPoseIndex += 1
            timeRemaining = 60
            isActive = true
        } else {
            // Session completed
            isActive = false
        }
    }
    
    private func repeatPose() {
        timeRemaining = 60
        isActive = true
    }
}

#Preview {
    PracticeSessionView(
        session: PracticeSession(
            id: UUID(),
            title: "Hızlı Ofis Rahatlaması",
            description: "Toplantı arası hızlı rahatlama",
            duration: 5,
            category: .office,
            level: .beginner,
            poses: ["Sandalye Esnemesi", "Boyun Döndürme", "Omuz Açma", "Nefes Çalışması"],
            isRecommended: true
        )
    )
}
