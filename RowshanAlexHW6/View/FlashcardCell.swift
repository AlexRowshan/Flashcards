//
//  FlashcardCell.swift
//  RowshanAlexHW6
//
//  Created by Alex Rowshan on 3/17/24.
//


import Foundation
import SwiftUI

struct FlashcardCell: View {
    let flashcard: Flashcard
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(flashcard.question)
                .font(.title3)
            Text(flashcard.answer)
                .font(.subheadline)
        }
    }
}

#Preview {
    FlashcardCell(flashcard: Flashcard(id: "10", question: "Who is cool?", answer: "Alex", isFavorite: false))
}
