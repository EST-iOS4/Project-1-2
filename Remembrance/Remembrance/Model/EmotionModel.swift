//
//  Emotion.swift
//  Remembrance
//
//  Created by JAY on 8/18/25.
//

import UIKit
//
//enum EmotionType: String, CaseIterable {
//    case Angry,
//    case Happy,
//         Blank, Flustered, Cry, Gloomy
//  
////  static func imageName(theme: String, emotion: EmotionType) -> String {
////          return "\(theme)\(emotion.rawValue)"
////      }
//  }
////    // 정적 메서드로 만들어서 Emotion 값을 외부에서 받음
////    static func image(theme: String, emotion: Emotion) -> UIImage? {
////        return UIImage(named: "\(theme)_\(emotion.rawValue)")
////    }
////  
//  
 
enum emotionType: CaseIterable {
  case Happy
  case Blank
  case Flustered
  case Angry
  case Cry
  case Gloomy
  
  var emotionString: String {
    switch self {
    case .Happy:
      return "Happy"
      
    case .Blank:
      return "Blank"
      
    case .Flustered:
      return "Flustered"
      
    case .Angry:
      return "Angry"
      
    case .Cry:
      return "Cry"
      
    case .Gloomy:
      return "Gloomy"
    }
  }
}
