//
//  LogModel.swift
//  Remembrance
//
//  Created by 엄정민 on 8/12/25.
//

import Foundation
import SwiftData

@Model
class LogModel: Identifiable {
    var id: UUID = UUID()
    var emoji: String
    var date: Date
    var title: String
    var content: String
    var tag: String
    
    init(
        id: UUID,
        emoji: String = "",
        date: Date = .now,
        title: String = "",
        content: String = "",
        tag: String = ""
    ) {
        self.id = id
        self.emoji = emoji
        self.date = date
        self.title = title
        self.content = content
        self.tag = tag
    }
}

@Model
class EmojiItem: Identifiable{
    @Attribute(.unique) var id: UUID
    var type: String          // "분노한" 등
    var count: Int
    var imageName: String     // Assets의 이름

    init(id: UUID = UUID(), type: String, count: Int, imageName: String) {
        self.id = id
        self.type = type
        self.count = count
        self.imageName = imageName
    }
}
