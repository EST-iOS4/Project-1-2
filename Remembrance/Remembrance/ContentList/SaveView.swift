//
//  SaveView.swift
//  Remembrance
//
//  Created by NaSangJin on 8/12/25.
//

import SwiftUI

struct SaveView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text("SaveView")
        Button("Dismiss") {
            dismiss()
        }
    }
}

#Preview {
    SaveView()
}
