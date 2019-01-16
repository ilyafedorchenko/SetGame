//
//  ViewController.swift
//  SetGame
//
//  Created by Илья Федорченко on 13/01/2019.
//  Copyright © 2019 Илья Федорченко. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var cardsCollection: [UIButton]!
  
  @IBAction func touchCard(_ sender: UIButton) {
    print()
  }
  
  @IBAction func serveCards(_ sender: UIButton) {
    guard game.serveCards() else {
      print("Error in game.serveCards")
      return
    }
    updateView()
    game.printStateForDebug()
  }
  
  @IBAction func newGame(_ sender: UIButton) {
    let newGame = Game.init()
    game = newGame
    updateView()
    game.printStateForDebug()
  }
  
  @IBOutlet weak var scoreLabel: UILabel!
  
  
  var game = Game.init()
  var allCardsList = [CardView]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    hideAllCards()
    updateView()
    game.printStateForDebug()
  }
  
  func hideAllCards() {
    for card in cardsCollection {
      card.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
      card.setTitle("", for: .normal)
      card.isEnabled = false
    }
  }
  
  
  func updateCVCollection() {
    allCardsList.removeAll()
    for card in game.cards{
      allCardsList.append(CardView(hashValue: card.key.hashValue, symbol: card.key.symbol, color: card.key.color, shading: card.key.shading, number: card.key.numberOfSymbols))
    }
  }
  
  func updateView() {
    let filtered = Array(game.cards.filter({$1 == .onTheTable}).keys)
    for card in filtered.indices {
      let cardVC = CardView(hashValue: filtered[card].hashValue, symbol: filtered[card].symbol, color: filtered[card].color, shading: filtered[card].shading, number: filtered[card].numberOfSymbols)
      cardsCollection[card].setAttributedTitle(cardVC.title, for: .normal)
      cardsCollection[card].backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      cardsCollection[card].isEnabled = true
      allCardsList.append(cardVC)
    }
  }
  

  
  
}

