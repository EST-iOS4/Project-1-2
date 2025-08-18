//
//  Extention.swift
//  Remembrance
//
//  Created by JAY on 8/18/25.
//

import SwiftUI

extension Image {
    init(theme: String, emotion: Emotion) {
        self.init("\(theme)\(emotion.rawValue)")
    }
}
