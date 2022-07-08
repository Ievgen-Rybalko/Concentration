//
//  Concentration.swift
//  Concentration
//
//  Created by Ievgen Rybalko on 23.06.2022.
//

import Foundation


class Concentration
{
    
    var cards = Array<Card>()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
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
                    indexOfOneAndOnlyFaceUpCard = nil
                } else {
                    //either no cards or 2 cards are face up
                    for flipDownIndex in cards.indices {
                        cards[flipDownIndex].isFaceUp = false
                    }
                    cards[index].isFaceUp = true
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
        print("Before shhh \(cards)")
        //TODO: Shuffle the cards
        cards.shuffle()
        print("After shhh \(cards)")
    }
}
