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
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
            
            //return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil    -- substituted with "oneAndOnly extention
            
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func checkCardMayBeTouched(at index: Int) -> Bool {
        return (!(cards[index].isMatched)) || ( (cards[index].isMatched) && (cards[index].isFaceUp) )
        
        
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at index: \(index) => chosen index not in the cards ")
       // if cards.count <= 2 {print("Game over!")} else {
            // TODO: game over and replay button
            
            if !cards[index].isMatched {
                if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                    //check if cards match
                    if cards[matchIndex].identifier == cards[index].identifier {
                        print ("***in if cards[matchIndex] == cards[index]: \(cards[matchIndex].identifier) == \( cards[index].identifier)")
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
    
    func restart() {
        print ("carrrds : \(cards)")
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            
        }
        
        cards.shuffle()
        print ("carrrdShuffle : \(cards)")
    }
    
    init(numberOfPairOfCards: Int) {
        assert( (( (cards.indices.count)/2 <= numberOfPairOfCards) && (numberOfPairOfCards > 0)), "Concentration.init (numberOfPairOfCards: \(numberOfPairOfCards) => chosen numberOfPairOfCards is too big or it is zero")
        for _ in 1...numberOfPairOfCards {
            let card = Card()
            //let matchingCard = card
            //cards.append(card)
            //cards.append(matchingCard)
            cards += [card, card]
            print ("cards: \(cards)")
        }
        //print("Before shhh \(cards)")
        //TODO: Shuffle the cards
       // cards.shuffle()
        //print("After shhh \(cards)")
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
