//
//  ViewController.swift
//  SetGame
//
//  Created by Илья Федорченко on 13/01/2019.
//  Copyright © 2019 Илья Федорченко. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  private var game = Game.init()
  private var cardsCollection = [CardView]()
  
  @IBOutlet weak var moreCardsButton: UIButton!
  @IBOutlet var buttonsCollection: [UIButton]!
  
  @IBAction func touchCard(_ sender: UIButton) {
    let buttonId = buttonsCollection.index(of: sender)
    if let cardId = cardsCollection.filter({$0.buttonId == buttonId}).first?.hashValue {
      game.selectCard(cardId: cardId)
      updateView()
      game.printStateForDebug()
      printViewState()
    }
    
  }
  
  @IBAction func serveCards(_ sender: UIButton) {
    game.serveCards()
    updateView()
    game.printStateForDebug()
  }
  
  @IBAction func newGame(_ sender: UIButton) {
    let newGame = Game.init()
    game = newGame
    for buttonId in buttonsCollection.indices {
      hideButton(buttonId)
    }
    moreCardsButton.isEnabled = true
    createCardsCollection()
    updateView()
    game.printStateForDebug()
  }
  
  @IBOutlet weak var scoreLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    createCardsCollection()
    for buttonId in buttonsCollection.indices {
      hideButton(buttonId)
    }
    updateView()
    game.printStateForDebug()
  }
  
  private func updateView() {
    updateCardsCollection()
    for buttonId in buttonsCollection.indices {
      if cardsCollection.contains(where: {$0.buttonId == buttonId}) {
        updateButton(buttonId)
      } else {
        for cardId in cardsCollection.indices {
          if cardsCollection[cardId].state == .onTheTable && cardsCollection[cardId].buttonId == nil {
            cardsCollection[cardId].buttonId = buttonId
            updateButton(buttonId)
            break
          }
        }
      }
    }
    if cardsCollection.filter({$0.buttonId != nil}).count == buttonsCollection.count {
      moreCardsButton.isEnabled = false
    } else {
      moreCardsButton.isEnabled = true
    }
    printViewState()
  }
  
  private func createCardsCollection() {
    cardsCollection.removeAll()
    for card in game.cards{
      cardsCollection.append(CardView(hashValue: card.key.hashValue, symbol: card.key.symbol, color: card.key.color, shading: card.key.shading, number: card.key.numberOfSymbols, state: card.value))
    }
  }
  
  private func updateCardsCollection() {
    for index in cardsCollection.indices {
      cardsCollection[index].state = game.cards.filter({$0.key.hashValue == cardsCollection[index].hashValue}).first?.value ?? .inDeck
    }
  }
  
  private func updateButton(_ buttonId: Int) {
    if let card = cardsCollection.filter({$0.buttonId == buttonId}).first {
      switch  card.state {
      case .onTheTable:
        buttonsCollection[buttonId].setAttributedTitle(card.title, for: .normal)
        buttonsCollection[buttonId].backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        buttonsCollection[buttonId].isEnabled = true
        buttonsCollection[buttonId].layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
      case .selected:
        buttonsCollection[buttonId].layer.borderWidth = 5.0
        buttonsCollection[buttonId].layer.borderColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
      case .selectionMatch:
        buttonsCollection[buttonId].layer.borderWidth = 5.0
        buttonsCollection[buttonId].layer.borderColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
      case .selectionMismatch:
        buttonsCollection[buttonId].layer.borderWidth = 5.0
        buttonsCollection[buttonId].layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
      case .matched:
        hideButton(buttonId)
//        moreCardsButton.isEnabled = true
        if let cardId = cardsCollection.index(of: card) {
          cardsCollection[cardId].buttonId = nil
        }
      default:
        print("updateButton: incorrect state .inDeck")
      }
    }
  }
  
  private func hideButton(_ buttonId: Int) {
    buttonsCollection[buttonId].backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    buttonsCollection[buttonId].layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    buttonsCollection[buttonId].setTitle("", for: .normal)
    buttonsCollection[buttonId].setAttributedTitle(NSAttributedString(string: ""), for: .normal)
    buttonsCollection[buttonId].isEnabled = false
    buttonsCollection[buttonId].layer.cornerRadius = 8.0
  }
  
  private func printViewState() {
    print("======================= cardsCollection ========================")
    print("hashValue - state - buttonId(-1 = nil)")
    for card in cardsCollection {
      print("\(card.hashValue) - \(card.state) - \(card.buttonId ?? -1)")
    }
    print("================== \(cardsCollection.count) ==================\n")
  }
}
