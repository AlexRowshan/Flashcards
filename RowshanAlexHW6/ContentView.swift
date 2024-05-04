//
//  ContentView.swift
//  RowshanAlexHW6
//
//  Created by Alex Rowshan on 3/17/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainTabView(flashcardViewModel: FlashcardViewModel())
    }
}

#Preview {
    ContentView()
}
