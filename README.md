# Remembrance
기억을 쌓고, 감정을 통해 기억을 되돌아보는 회고앱입니다.
---
# 팀원
박재이 이재영 나상진 엄정민
---
# 기능소개
<aside>
📌

## 1. 핵심 기능

- **회고 작성·열람·편집·삭제가 가능합니다.**
- **카테고리‧태그 관리**: 회고마다 감정을 넣어 통계를 잡습니다.
- **주·월별 통계 뷰**: 기간별 회고와 감정통계, 글자수당 1cm를 집계해서 한눈에 보여줍니다.

---

## 2. 데이터 저장

- **@AppStorage 활용**: 테마, 글꼴 크기, 첫 실행 플래그 등 간단한 설정 데이터는 UserDefaults + `@AppStorage`로 관리합니다.
- **SwiftData 활용**: 회고 데이터는 SwiftData로 저장합니다.

---

## 3. UI/UX 디자인

- **SwiftUI 네이티브 컴포넌트 우선 사용**: `NavigationStack`, `List`, `Form` 등을 사용했습니다.
- **다크모드 대응**: 시스템 모드에 맞춰 색상이 자동 전환됩니다.
- **지원 디바이스**: 아이폰(세로만 지원)과 아이패드(가로, 세로 모두)를 모두 지원합니다. 
macOS는 지원하지 않습니다.

---

## 4. 접근성

- **동적 글꼴 사이즈**: 사용자 설정에 따라서 폰트 크기가 업데이트 됩니다.
- **다국어 지원**: 다국어는 지원하지 않습니다. 한국어만 지원됩니다.
</aside>
---
# 개발환경
---
# 폴더구조
<pre lang="markdown">
```
Remembrance
├── Model
│   ├── EmojisSeed.swift
│   └── LogModel.swift
│
├── Main
│   └── HomeView.swift
│
├── ContentList
│   ├── ListView.swift
│   ├── SaveView.swift
│   └── ListDetailView.swift
│
├── OnBoarding
│   └── OnBoardingView.swift
│
├── Setting
│   └── SettingView.swift
│
├── Statistics
│   └── StatisticsView.swift
│
└── Assets
```
</pre>
