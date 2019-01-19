//
//  Game.swift
//  SetGame
//
//  Created by Илья Федорченко on 17/01/2019.
//  Copyright © 2019 Илья Федорченко. All rights reserved.
//

import Foundation

class Game {
  
  private let numberOfCardsToStart = 9, numberOfCardsToAdd = 3, numberOfCardsToSelect = 3, totalNumberOfCards = 81
  private let propertyValueRange = 0...2
  
  var cards = [Card:CardState]() //TODO: protect in API?
  
//  private func hashValue(_ symbol:Int,_ color: Int,_ shading: Int,_ numberOfSymbols: Int,_ propertyRange: ClosedRange<Int>) -> Int {
//    let count = Double(propertyRange.count)
//    return symbol * Int(pow(count,3.0)) + color * Int(pow(count,2.0)) + shading * Int(pow(count,1.0)) + numberOfSymbols
//  }
  
  init() {
    
    var randomiser:[Int] = Array(0...80)
    randomiser.shuffle()
    //FIXME: randomiser is not perfect
    
    for symbol in propertyValueRange {
      for color in propertyValueRange {
        for shading in propertyValueRange {
          for number in propertyValueRange {
            let newCard = Card.init(symbol: symbol, color: color, shading: shading, numberOfSymbols: number, hashValue: randomiser.popLast() ?? 0)
            cards[newCard] = CardState.inDeck
          }
        }
      }
    }
    changeStateForNumberOfCards(from: .inDeck, to: .onTheTable, numberOfCards: numberOfCardsToStart) ? print("changeState - Ok") : print("changeState - Err")
    
        print("======================= INIT ========================")
        let cards1 = self.cards.sorted(by: {$0.key.hashValue < $1.key.hashValue})
        for card in cards1 {
          print("\(card.key.hashValue) - \(card.key.symbol) - \(card.key.color) - \(card.key.shading) - \(card.key.numberOfSymbols) - \(card.value)")
        }
        print("================== \(cards1.count) ==================\n")
    
        print("======================= DECK ========================")
        let cards2 = self.cards.filter({$1 == .inDeck}).sorted(by: {$0.key.hashValue < $1.key.hashValue})
        for card in cards2 {
          print("\(card.key.hashValue) - \(card.key.symbol) - \(card.key.color) - \(card.key.shading) - \(card.key.numberOfSymbols) - \(card.value)")
        }
        print("================== \(cards2.count) ==================\n")
    
        print("======================= TABLE ========================")
        let cards3 = self.cards.filter({$1 == .onTheTable}).sorted(by: {$0.key.hashValue < $1.key.hashValue})
        for card in cards3 {
          print("\(card.key.hashValue) - \(card.key.symbol) - \(card.key.color) - \(card.key.shading) - \(card.key.numberOfSymbols) - \(card.value)")
        }
        print("================== \(cards3.count) ==================\n")
  }
  
  private func changeStateForNumberOfCards(from initialState: CardState, to newState: CardState, numberOfCards: Int) -> Bool {
    var success = true
    for _ in 1...numberOfCards {
      if let randomCard = cards.first(where: {$0.value == initialState}) {
        cards[randomCard.key] = newState
      } else {
        success = false
        break
      }
    }
    return success
  }
  
  private func checkSet() -> Bool {
    
    let filteredCards = Array(cards.filter({$0.value == .selected}).keys)
    
    var success = true
    for propertyValue in propertyValueRange {
      if filteredCards.filter({$0.symbol == propertyValue}).count == 2 {
        success = false
        break
      }
    }
    
    if !success {
      success = true
      for propertyValue in propertyValueRange {
        if filteredCards.filter({$0.color == propertyValue}).count == 2 {
          success = false
          break
        }
      }
    }
    
    if !success {
      success = true
      for propertyValue in propertyValueRange {
        if filteredCards.filter({$0.shading == propertyValue}).count == 2 {
          success = false
          break
        }
      }
    }
    
    if !success {
      success = true
      for propertyValue in propertyValueRange {
        if filteredCards.filter({$0.numberOfSymbols == propertyValue}).count == 2 {
          success = false
          break
        }
      }
    }
    return success
  }
  
  func getCardState(cardId: Int) -> CardState? {
    guard let card = cards.filter({$0.key.hashValue == cardId}).first else {
      print("\nError in func selectCard(\(cardId)), can't find this card\n")
      return nil
    }
    return cards[card.key]
  }
  
  func selectCard(cardId: Int) {
    //TODO check selection of card in correct state
    guard let card = cards.filter({$0.key.hashValue == cardId}).first else {
      print("\nError in func selectCard(\(cardId)), can't find this card\n")
      return
    }
    
    switch cards[card.key] {
      
    case .onTheTable?:
      if cards.filter({$1 == .selected}).count == numberOfCardsToSelect{
        changeStateForNumberOfCards(from: .selected, to: .onTheTable, numberOfCards: numberOfCardsToSelect) ? print("changeState - Ok") : print("changeState - Err")
        cards[card.key] = .selected
      } else {
        
        cards[card.key] = .selected
        
        if cards.filter({$1 == .selected}).count == numberOfCardsToSelect && checkSet(){
          changeStateForNumberOfCards(from: .selected, to: .matched, numberOfCards: numberOfCardsToSelect) ? print("changeState - Ok") : print("changeState - Err")
        }
      }
      
    case .selected?:
      cards[card.key] = .onTheTable
      
    default:
      print("\nError in func selectCard(\(cardId)), can't select this card - wrong  state\n")
    }
  }
  
  
  
  func serveCards() {
    if !changeStateForNumberOfCards(from: .inDeck, to: .onTheTable, numberOfCards: numberOfCardsToAdd) {
      print("\nError in func serveCards(\(numberOfCardsToAdd)), no more cards to serve\n")
      return
    } else {
      
      print("======================= DECK ========================")
      let cards2 = self.cards.filter({$1 == .inDeck}).sorted(by: {$0.key.hashValue < $1.key.hashValue})
      for card in cards2 {
        print("\(card.key.hashValue) - \(card.key.symbol) - \(card.key.color) - \(card.key.shading) - \(card.key.numberOfSymbols) - \(card.value)")
      }
      print("================== \(cards2.count) ==================\n")

      print("======================= TABLE ========================")
      let cards3 = self.cards.filter({$1 == .onTheTable}).sorted(by: {$0.key.hashValue < $1.key.hashValue})
      for card in cards3 {
        print("\(card.key.hashValue) - \(card.key.symbol) - \(card.key.color) - \(card.key.shading) - \(card.key.numberOfSymbols) - \(card.value)")
      }
      print("================== \(cards3.count) ==================\n")
    }
  }
  
  func printStateForDebug() {
    print("======================= SELECTED ========================")
    let cards4 = self.cards.filter({$1 == .selected}).sorted(by: {$0.key.hashValue < $1.key.hashValue})
    for card in cards4 {
      print("\(card.key.hashValue) - \(card.key.symbol) - \(card.key.color) - \(card.key.shading) - \(card.key.numberOfSymbols) - \(card.value)")
    }
    print("================== \(cards4.count) ==================\n")

    print("======================= MATCHED ========================")
    let cards5 = self.cards.filter({$1 == .matched}).sorted(by: {$0.key.hashValue < $1.key.hashValue})
    for card in cards5 {
      print("\(card.key.hashValue) - \(card.key.symbol) - \(card.key.color) - \(card.key.shading) - \(card.key.numberOfSymbols) - \(card.value)")
    }
    print("================== \(cards5.count) ==================\n")

    print("======================= TABLE ========================")
    let cards3 = self.cards.filter({$1 == .onTheTable}).sorted(by: {$0.key.hashValue < $1.key.hashValue})
    for card in cards3 {
      print("\(card.key.hashValue) - \(card.key.symbol) - \(card.key.color) - \(card.key.shading) - \(card.key.numberOfSymbols) - \(card.value)")
    }
    print("================== \(cards3.count) ==================\n")
  }
}

