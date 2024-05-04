//
// FlashcardListPage.swift
// RowshanAlexHW6
//
// Created by Alex Rowshan on 3/17/24.
//

import Foundation
import SwiftUI

struct FlashcardListPage: View {
    @EnvironmentObject var flashcardViewModel: FlashcardViewModel
    
    var body: some View {
        NavigationStack {
            List($flashcardViewModel.flashcards, editActions: .delete) { $flashcard in
                NavigationLink(value: flashcard) {
                    FlashcardCell(flashcard: flashcard)
                }
            }
            .navigationTitle("Flashcards")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: EditFlashCardPage()) {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(for: Flashcard.self) { flashcard in
                EditFlashCardPage(flashcard: flashcard)
            }
        }
    }
}

#Preview {
    FlashcardListPage()
        .environmentObject(FlashcardViewModel())
}
