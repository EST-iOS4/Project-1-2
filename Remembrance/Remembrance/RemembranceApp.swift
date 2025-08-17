//
//  RemembranceApp.swift
//  Remembrance
//
//  Created by JaeyoungLee on 8/11/25.
//

import SwiftUI
import SwiftData

@main
struct RemembranceApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: [LogModel.self, EmojiItem.self])
    }
}

