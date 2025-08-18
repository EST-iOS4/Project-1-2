//
//  ThemeManager.swift
//  Remembrance
//
//  Created by JAY on 8/18/25.
//

import SwiftUI
import Combine

class ThemeManager: ObservableObject {
    @AppStorage("currentTheme") var currentTheme: String = "emoji"

}
