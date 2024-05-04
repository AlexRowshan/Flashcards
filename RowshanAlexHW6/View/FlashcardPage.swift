import SwiftUI

struct FlashcardPage: View {
    let OFFSET_X = 450.0
    let OFFSET_Y = 900.0

    @StateObject var flashcardViewModel = FlashcardViewModel()

    @State var isShowingQuestion = true

    @State var offsetX = 0.0

    @State var offsetY = 0.0

    @State var isHidden = false

    var title: String {
        guard let currentFlashcard = flashcardViewModel.currentFlashcard else {
            return ""
        }
        
        return isShowingQuestion ? currentFlashcard.question : currentFlashcard.answer
    }

    var isFavorite: Bool {
        return flashcardViewModel.currentFlashcard?.isFavorite ?? false
    }

    func showRandomFlashCard() {
        withAnimation(.linear(duration: 1)) {
            offsetY = -OFFSET_Y
            isHidden = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            offsetY = OFFSET_Y
            flashcardViewModel.randomize()
            withAnimation(.linear(duration: 1)) {
                offsetY = 0
            }
            isHidden = false
            isShowingQuestion = true
        }
    }

    func toggleQuestionAnswer() {
        withAnimation(.linear(duration: 0.5)){
            isShowingQuestion = !isShowingQuestion
        }
    }

    func showNextCard() {
        withAnimation(.linear(duration: 1)) {
            offsetX = -OFFSET_X
            isHidden = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            offsetX = OFFSET_X
            flashcardViewModel.next()
            withAnimation(.linear(duration: 1)) {
                offsetX = 0
            }
            isHidden = false
            isShowingQuestion = true
        }
    }

    func showPreviousCard() {
        withAnimation(.linear(duration: 1)) {
            offsetX = OFFSET_X
            isHidden = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            offsetX = -OFFSET_X
            flashcardViewModel.previous()
            withAnimation(.linear(duration: 1)) {
                offsetX = 0
            }
            isHidden = false
            isShowingQuestion = true
        }
    }

    var body: some View {
        ZStack {
            VStack {
                Text(title)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(isShowingQuestion ? .green: .red)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.indigo)
            .onTapGesture(count: 2) {
                toggleQuestionAnswer()
            }
            .onTapGesture {
                showRandomFlashCard()
            }
            .opacity(isHidden ? 0.0 : 1.0)
            .offset(x: offsetX, y: offsetY)
            .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                    .onEnded { value in
                        switch(value.translation.width, value.translation.height) {
                            case (...0, -30...30):
                                showNextCard() // show next card here
                            case (0..., -30...30):
                                showPreviousCard() // show previous card here
                            default:
                                print("Gesture not recognized")
                        }
                    }
                )

            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        flashcardViewModel.toggleFavorite()
                    }) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(isFavorite ? .yellow : .gray)
                    }
                    .padding()
                }
                Spacer()
            }
        }
        .padding()
    }
}

#Preview {
    FlashcardPage()
}
