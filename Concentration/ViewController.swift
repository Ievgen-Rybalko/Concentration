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
            updateFlipsCount()
        }
    }
    
    @IBOutlet private weak var flipCountLable: UILabel! {
        didSet {
            updateFlipsCount()
        }
    }
    
    private func updateFlipsCount() {
        
            let attributes: [NSAttributedString.Key:Any] = [
                .strokeWidth : 5.0,
                .strokeColor : UIColor.init(red: 0.7, green: 0.7, blue: 1, alpha: 0.8)
            ]
            let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
            flipCountLable.attributedText = attributedString
        
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    @IBAction private func restartButton() {
        flipCount = 0
        game.restart()
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        
        
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            
            let touchMayCount = game.checkCardMayBeTouched(at: cardNumber)
            print("touchMayCount: \(touchMayCount)")
            guard touchMayCount else {return}
            flipCount += 1
        
            
            //flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        }
        
        
        
    }
    
    private func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    private func updateViewFromModel () {
        
        var cardMatchedCount = numberOfPairsOfCards * 2
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            //print ("card \(card)")
            if card.isFaceUp {
                button.setTitle(emojify(for: card), for: UIControl.State.normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? UIColor.init(red: 1, green: 1, blue: 1, alpha: 0) : UIColor.red
            }
            
            if card.isMatched {
                cardMatchedCount -= 1
            }
        }
        if cardMatchedCount <= 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.restartButton() // do stuff 2 seconds later
                }
//            delayWithSeconds(2) { [self] in
//                restartButton()
//            }
            
        }
        print (" ========= ")
    }
    
    private var emojiChoices: Array<String> = ["🐶","🐱","🐻","🦁","🐣","🐸","🦋","🐙"]
    
    
    private var emoji = [Card:String]() // Dictionary<Int,String>
        
    private func emojify(for cardKey: Card) -> String {
        
        if emoji[cardKey] == nil {
            print ("nil emoji[cardKey]: \(cardKey)")
            if emojiChoices.count > 0 {
                emoji[cardKey] = emojiChoices.remove(at: emojiChoices.count.arc4random)
//                print("emojiChoises arr: \(emojiChoices)")
//                print ("emoji[card] \(String(describing: emoji[card])) ,choises \(emojiChoices.count)")
//                print ("emojiChoices: \(emojiChoices)")
            }
            
        }
        
        //return emoji[card.identifier] ?? "?"
        if emoji[cardKey] != nil {
            print ("not-nil emoji[cardKey]: \(cardKey)")
            
            return emoji[cardKey]!
        } else {
            return "?"
        }
    
    }
      
}


    
extension Int {
        var arc4random: Int {
            if self > 0 {
                return Int(arc4random_uniform(UInt32(self)))
            }
            else if self < 0 {
                return -Int(arc4random_uniform(UInt32(abs(self))))
            } else {
                return 0
            }
        }
}
    

