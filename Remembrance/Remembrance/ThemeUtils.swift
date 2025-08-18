//
//  ThemeUtils.swift
//  Remembrance
//
//  Created by JAY on 8/18/25.
//

import Foundation

let themeMap: [String: String] = [
    "pepe": "페페",
    "blossom": "블러썸",
    "emoji": "기본"
]

func themeDisplayName(for theme: String) -> String {
    return themeMap[theme] ?? "기본"
}
