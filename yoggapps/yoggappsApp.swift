//
//  yoggappsApp.swift
//  yoggapps
//  Modern Yoga App for Busy Professionals
//  Created by Hakan Karakuş on 10.08.2025.
//

import SwiftUI

@main
struct yoggappsApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .preferredColorScheme(.light)
        }
    }
}
