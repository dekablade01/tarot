//
//  CardBoardViewModel.swift
//  tarot
//
//  Created by Issarapong Poesua on 15/2/22.
//

import SwiftUI

extension CardBoardView {
    
    @MainActor class ViewModel: ObservableObject {
        
        private var deckOfCards: [Tarot] = []
        
        @Published private(set) var openedCardsWithLocations: [(card: Card, location: CGSize)] = []

        private(set) var interactableDeckOfCards: [Card] = []

        init(tarots: [Tarot]) {
            deckOfCards = tarots
            reset()
        }
        
        func pickCard() -> Card {
            return interactableDeckOfCards.removeFirst()
        }
        
        func updateLocation(of card: Card, location: CGSize) {
            _ = openedCardsWithLocations
                .firstIndex { $0.card == card }
                .map { openedCardsWithLocations.remove(at: $0) }
            return openedCardsWithLocations.append((card: card, location: location))
        }
        
        func reset() {
            interactableDeckOfCards = deckOfCards
                .shuffled()
                .map { Card(tarot: $0, direction: [.headUp, .headDown].randomElement()!) }
        }
    }
}
