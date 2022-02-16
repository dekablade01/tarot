//
//  Card.swift
//  tarot
//
//  Created by Issarapong Poesua on 15/2/22.
//

import UIKit

struct Card: Hashable {
    
    enum Direction {
        case headUp, headDown
        
        var radians: CGFloat {
            switch self {
            case .headUp:       return 0
            case .headDown:     return .pi
            }
        }
    }
    
    let direction: Direction
    let tarot: Tarot
    
    init(tarot: Tarot, direction: Direction) {
        self.tarot = tarot
        self.direction = direction
    }
    
}
