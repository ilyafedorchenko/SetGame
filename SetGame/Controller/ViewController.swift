//
//  ViewController.swift
//  SetGame
//
//  Created by Илья Федорченко on 13/01/2019.
//  Copyright © 2019 Илья Федорченко. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var cardsButtonCollection: [UIButton]!
  
  let game = Game.init()
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    for (index, card) in cardsButtonCollection.enumerated() {
//      card.setTitle("\(game.cards[index].symbol)-\(game.cards[index].color)-\(game.cards[index].shading)-\(game.cards[index].numberOfSymbols)", for: .normal)
    var result = game.changeStateForFirstNumberOfCards(initialState: .inDeck, newState: .selected, numberOfCards: 3)
    
    for card in game.cards {
      print("\(card.key.color)-\(card.value)")
    }
    
    result = game.checkSet_color()
    print(result)

  }
}

