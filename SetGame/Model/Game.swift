//
//  Game.swift
//  SetGame
//
//  Created by Илья Федорченко on 13/01/2019.
//  Copyright © 2019 Илья Федорченко. All rights reserved.
//

import Foundation

class Game {
  
  enum CardState {
    case inDeck
    case onTheTable
    case selected
    case matched
  }
  
  private let numberOfCardsToStart = 12, numberOfCardsToAdd = 3, numberOfCardsToSelect = 3
  private let propertyValueRange = 0...2
  
  var cards = [Card:CardState]() //TODO: protect in API?
  
  private func hashValue(_ symbol:Int,_ color: Int,_ shading: Int,_ numberOfSymbols: Int,_ propertyRange: ClosedRange<Int>) -> Int {
    let count = Double(propertyRange.count)
    return symbol * Int(pow(count,3.0)) + color * Int(pow(count,2.0)) + shading * Int(pow(count,1.0)) + numberOfSymbols
  }
  
  init() {
    
    for symbol in propertyValueRange {
      for color in propertyValueRange {
        for shading in propertyValueRange {
          for number in propertyValueRange {
            let newCard = Card.init(symbol: symbol, color: color, shading: shading, numberOfSymbols: number, hashValue: hashValue(symbol, color, shading, number, propertyValueRange))
            cards[newCard] = CardState.inDeck
          }
        }
      }
    }
    changeStateForFirstNumberOfCards(from: .inDeck, to: .onTheTable, numberOfCards: numberOfCardsToStart)
  }
  
  private func changeStateForFirstNumberOfCards(from initialState: CardState, to newState: CardState, numberOfCards: Int) -> Bool {
    var success = true
    for _ in 1...numberOfCards {
      if let first = cards.first(where: {$0.value == initialState}) {
        cards[first.key] = newState
      } else {
        success = false
        break
      }
    }
    return success
  }
  
  private func checkSet_color() -> Bool {
    
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
  
  func selectCard(cardId: Int) -> Bool {
    if let card = cards.filter({$0.key.hashValue == cardId}).first {
      cards[card.key] = .selected
      return true
    }
    return false
  }
  
  func serveCards(numberOfCards: Int) -> Bool {
    if !changeStateForFirstNumberOfCards(from: .inDeck, to: .onTheTable, numberOfCards: numberOfCards) {
      print("Error in func serveCards \(numberOfCards), no more cards to serve")
      return false
    } else {
      return true
    }
  }
  
  func printStateForDebug() {
    let cards = self.cards.sorted(by: {$0.key.hashValue < $1.key.hashValue})
    for card in cards {
      print("\(card.key.hashValue) - \(card.key.symbol) - \(card.key.color) - \(card.key.shading) - \(card.key.numberOfSymbols) - \(card.value)")
    }
    print("===================DECK===================")
    
  }
  
  
  
}
