//
//  Flashcard.swift
//  RowshanAlexHW6
//
//  Created by Alex Rowshan on 3/17/24.
//

import Foundation
struct Flashcard: Hashable, Identifiable, Codable{
    let id: String
    let question: String
    let answer: String
    let isFavorite: Bool
    
    
}

