//
//  Card.swift
//  Concentration
//
//  Created by Ievgen Rybalko on 23.06.2022.
//

import Foundation

struct Card
{
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0

    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
