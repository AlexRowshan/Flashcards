//
//  EditFlashCardPage.swift
//  RowshanAlexHW6
//
//  Created by Alex Rowshan on 3/17/24.
//

import Foundation
import SwiftUI

struct EditFlashCardPage: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var flashcardViewModel: FlashcardViewModel
    
    private var flashcard: Flashcard?
    
    @State private var question: String = ""
    @State private var answer: String = ""
    @State private var isFavorite: Bool = false
    
    init(flashcard: Flashcard? = nil) {
        self.flashcard = flashcard
        if let flashcard = flashcard {
            _question = State(initialValue: flashcard.question)
            _answer = State(initialValue: flashcard.answer)
            _isFavorite = State(initialValue: flashcard.isFavorite)
        }
    }
    
    var body: some View {
        VStack(spacing: 24.0){
            TextField("Question", text: $question)
                .padding()
            TextField("Answer", text: $answer)
                .padding()
            Toggle("Is Favorite?", isOn: $isFavorite)
                .padding()
        }
        .navigationTitle(flashcard == nil ? "New Card" : "Edit Card")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    if let flashcard = flashcard {
                        let updatedFlashcard = Flashcard(
                            id: flashcard.id,
                            question: question,
                            answer: answer,
                            isFavorite: isFavorite
                        )
                        if let index = flashcardViewModel.getIndex(for: flashcard) {
                            flashcardViewModel.update(flashcard: updatedFlashcard, at: index)
                        }
                    } else {
                      
                        let newFlashcard = Flashcard(
                            id: UUID().uuidString,
                            question: question,
                            answer: answer,
                            isFavorite: isFavorite
                        )
                        flashcardViewModel.append(flashcard: newFlashcard)
                    }
                    dismiss()
                }
                .disabled(question.isEmpty || answer.isEmpty)
            }
        }
    }
}

#Preview {
    EditFlashCardPage()
}
