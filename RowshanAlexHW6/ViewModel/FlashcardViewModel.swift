//
//  FlashcardViewModel.swift
//  RowshanAlexHW6
//
//  Created by Alex Rowshan on 3/17/24.
//

import Foundation
class FlashcardViewModel: FlashcardsModel, ObservableObject{
    
    
    private var flashcardsFilePath: URL
    
    @Published var flashcards: [Flashcard] = [] {
            didSet {
                save()
            }
        }
    
    @Published var currentIndex: Int = 0 {
            didSet {
                if currentIndex < 0 {
                    currentIndex = 0
                } else if currentIndex >= flashcards.count {
                    currentIndex = flashcards.count - 1
                }
            }
        }
    
    
    
    init(){
        
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        self.flashcardsFilePath = documentDirectory.appendingPathComponent("flashcards.json")
        
        if let loadFlashcards = load(){
            self.flashcards = loadFlashcards
        }
        else{
            flashcards = [
                Flashcard(
                    id: "1",
                    question: "What is the best university in California?",
                    answer: "USC",
                    isFavorite: true
                ),
                Flashcard(
                    id: "2",
                    question: "What's the most interesting course @ USC?",
                    answer: "ITP-342",
                    isFavorite: false
                ),
                Flashcard(
                    id: "3",
                    question: "What's the best programming language?",
                    answer: "Swift",
                    isFavorite: false
                ),
                Flashcard(
                    id: "4",
                    question: "What UI Framework are we using?",
                    answer: "SwiftUI",
                    isFavorite: false
                ),
                Flashcard(
                    id: "5",
                    question: "What's better Cats or Dogs?",
                    answer: "Dogs",
                    isFavorite: true
                )
                
            ]
            
        }
        
    }
    
    var numberOfFlashcards: Int { return flashcards.count }

    var currentFlashcard: Flashcard? { return flashcards[currentIndex] }
    
    var favoriteFlashcards: [Flashcard] {
        var favCards: [Flashcard] = []
        
        for card in flashcards{
            if card.isFavorite{
                favCards.append(card)
            }
        }
        
        return favCards
    }
    
    func randomize(){
        var randomIndex = Int.random(in: 0..<flashcards.count)
        
        while randomIndex == currentIndex{
            randomIndex = Int.random(in: 0..<flashcards.count)
        }
        
        currentIndex = randomIndex
    }
    
    func next(){
        currentIndex += 1
        if currentIndex == flashcards.count{
            currentIndex = 0
        }
    }
    
    func previous(){
        currentIndex -= 1
        if currentIndex < 0{
            currentIndex = 0
        }
    }
    func flashcard(at index: Int) -> Flashcard?{
        if index >= 0 && index <= flashcards.count {
            return flashcards[index]
        }
        return nil
    }
    
    func append(flashcard: Flashcard){
        flashcards.append(flashcard)
    }
    
    
    func insert(flashcard: Flashcard, at index: Int){
        if index >= 0 && index <= flashcards.count {
                    flashcards.insert(flashcard, at: index)
        }
    }
    
    func removeFlashcard(at index: Int){
        
        if index >= 0 && index < flashcards.count {
            flashcards.remove(at: index)
        }
    }
    
    func getIndex(for flashcard: Flashcard) -> Int?{
        
        for i in 0..<flashcards.count {
               if flashcard.id == flashcards[i].id {
                   return i
               }
           }
           return nil
    }
    
    func update(flashcard: Flashcard, at index: Int){
        if index >= 0 && index < flashcards.count {
            flashcards[index] = flashcard 
        }
    }
    
    func toggleFavorite() {
        let currFlashcard = flashcards[currentIndex]
        
        let newFlashcard = Flashcard(id: currFlashcard.id, question: currFlashcard.question, answer: currFlashcard.answer, isFavorite: !(currFlashcard.isFavorite))
        
        update(flashcard: newFlashcard, at: currentIndex)
        
        
    }
    
    private func load() -> [Flashcard]?{
        do {
                guard FileManager.default.fileExists(atPath: flashcardsFilePath.path) else { return nil }
                let data = try Data(contentsOf: flashcardsFilePath)
                let decoder = JSONDecoder()
                let flashcards = try decoder.decode([Flashcard].self, from: data)
                return flashcards
            } catch {
                print("Error 1: \(error)")
                return nil
            }
    }
    
    private func save(){
        do {
                let encoder = JSONEncoder()
                let flashcardsData = try encoder.encode(flashcards)
                if let flashcardsString = String(data: flashcardsData, encoding: .utf8) {
                    
                    if let dataToWrite = flashcardsString.data(using: .utf8) {
                        try dataToWrite.write(to: flashcardsFilePath, options: [.atomicWrite])
                    }
                }
            } catch {
                print("Error 2: \(error)")
            }
    }
    
    
    
}

