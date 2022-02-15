//
//  Card.swift
//  tarot
//
//  Created by Issarapong Poesua on 15/2/22.
//

import Foundation

struct Card {
    
    enum Direction {
        case headUp, headDown
    }
    
    let direction: Direction
    let tarot: Tarot
    
    init(tarot: Tarot, direction: Direction) {
        self.tarot = tarot
        self.direction = direction
    }
    
}
