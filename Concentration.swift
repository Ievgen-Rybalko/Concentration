//
//  Concentration.swift
//  Concentration
//
//  Created by Ievgen Rybalko on 23.06.2022.
//

import Foundation


class Concentration
{
    
    private(set) var cards = Array<Card>()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    
    func chooseCard(at index: Int) {
        if cards.count <= 2 {print("Game over!")} else {
            // TODO: game over and replay button
            
            if !cards[index].isMatched {
                if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                    //check if cards match
                    if cards[matchIndex].identifier == cards[index].identifier {
                        cards[matchIndex].isMatched = true
                        cards[index].isMatched = true
                    }
                    cards[index].isFaceUp = true
            
                } else {
                    //either no cards or 2 cards are face up
                    indexOfOneAndOnlyFaceUpCard = index
                }
            }
        }
        
    }
    
    init(numberOfPairOfCards: Int) {
        for _ in 1...numberOfPairOfCards {
            let card = Card()
            //let matchingCard = card
            //cards.append(card)
            //cards.append(matchingCard)
            cards += [card, card]
        }
        //print("Before shhh \(cards)")
        //TODO: Shuffle the cards
        cards.shuffle()
        //print("After shhh \(cards)")
    }
}
