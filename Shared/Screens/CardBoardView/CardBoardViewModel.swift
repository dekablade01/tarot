//
//  CardBoardViewModel.swift
//  tarot
//
//  Created by Issarapong Poesua on 15/2/22.
//

import Foundation

extension CardBoardView {
    
    @MainActor class ViewModel: ObservableObject {
        
        private var deckOfCards: [Tarot] = []
        private var interactableDeckOfCards: [Card] = []
        private var openedCards: [Card] = []
        
        init(tarots: [Tarot]) {
            self.deckOfCards = tarots
        }
        
        func pickCard() -> Card {
            let card = interactableDeckOfCards.removeFirst()
            openedCards.append(card)
            return card
        }
        
        func reset() {
            interactableDeckOfCards = deckOfCards
                .map { Card(tarot: $0, direction: [.headUp, .headDown].randomElement()!) }
                .shuffled()
        }
    }
}
