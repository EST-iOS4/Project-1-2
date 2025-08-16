//
//  EmojisSeed.swift
//  Remembrance
//
//  Created by 엄정민 on 8/16/25.
//

// Model/Seed.swift
import SwiftData

let emojiCatalog: [(String, String)] = [
    ("멍때리는", "emojiBlank"),
    ("슬픈", "emojiCry"),
    ("분노한", "emojiAngry"),
    ("당황한", "emojiFlustered"),
    ("우울한", "emojiGloomy"),
    ("행복한", "emojiHappy")
]

func seedEmojisIfNeeded(context: ModelContext) throws {
    let existing = try context.fetch(FetchDescriptor<EmojiItem>())
    if existing.isEmpty {
        for (type, image) in emojiCatalog {
            context.insert(EmojiItem(type: type, count: 0, imageName: image))
        }
        try context.save()
    }
}
