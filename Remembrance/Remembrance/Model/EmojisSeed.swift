////
////  EmojisSeed.swift
////  Remembrance
////
////  Created by 엄정민 on 8/16/25.
////
//
//// Model/Seed.swift
//import SwiftData
//
////let emojiCatalog: [(String, String)] = [
////    ("멍때리는", "emojiBlank"),
////    ("슬픈", "emojiCry"),
////    ("분노한", "emojiAngry"),
////    ("당황한", "emojiFlustered"),
////    ("우울한", "emojiGloomy"),
////    ("행복한", "emojiHappy")
////]
//
//let emojiCatalog: [(type: String, image: String, count: Int)] = [
//    ("멍때리는", "emojiBlank",   1),
//    ("슬픈",     "emojiCry",      6),
//    ("분노한",   "emojiAngry",    2),
//    ("부끄러운",   "emojiFlustered",10),
//    ("우울한",   "emojiGloomy",  3),
//    ("행복한",   "emojiHappy",   8)
//]
//
//func seedEmojisIfNeeded(context: ModelContext) throws {
////    let existing = try context.fetch(FetchDescriptor<EmojiItem>())
////    if existing.isEmpty {
////        for (type, image) in emojiCatalog {
////            context.insert(EmojiItem(type: type, count: 0, imageName: image))
////        }
////        try context.save()
////    }
//    
//    let existing = try context.fetch(FetchDescriptor<EmojiItem>())
//    guard existing.isEmpty else { return }  // 데이터 있으면 패스
//
//    for e in emojiCatalog {
//        context.insert(EmojiItem(type: e.type, count: e.count, imageName: e.image))
//    }
//    try context.save()
//}
