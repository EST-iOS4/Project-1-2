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
