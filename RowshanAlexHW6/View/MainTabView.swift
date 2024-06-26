//
//  MainTabView.swift
//  RowshanAlexHW6
//
//  Created by Alex Rowshan on 3/18/24.
//

import Foundation
import SwiftUI

struct MainTabView: View {
    
    @StateObject var flashcardViewModel: FlashcardViewModel
    
    var body: some View {
        TabView{
            FlashcardPage()
                .tabItem {
                    Label("Question", systemImage: "questionmark.circle")
                }
            FlashcardListPage()
                .tabItem {
                    Label("Cards", systemImage: "square.stack.3d.up.fill")
                }
            FavoritesFlashcardListPage()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
        .environmentObject(flashcardViewModel)
    }
}

#Preview {
    MainTabView(flashcardViewModel: FlashcardViewModel())
}
