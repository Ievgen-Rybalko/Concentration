//
//  ViewController.swift
//  Concentration
//
//  Created by Ievgen Rybalko on 22.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        get {
            return (cardButtons.count + 1) / 2
        }
    }
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLable.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet private weak var flipCountLable: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
    
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            //flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        }
        
        
    }
    
    private func updateViewFromModel () {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? UIColor.init(red: 1, green: 1, blue: 1, alpha: 0) : UIColor.red
            }
        }
    }
    
    private var emojiChoices: Array<String> = ["🐶","🐱","🐻","🦁","🐣","🐸","🦋","🐙"]
    
    
    private var emoji = [Int:String]() // Dictionary<Int,String>
        
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil {
            
            if emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
            
        }
        
        //return emoji[card.identifier] ?? "?"
        if emoji[card.identifier] != nil {
            return emoji[card.identifier]!
        } else {
            return "?"
        }
        
    }

}

