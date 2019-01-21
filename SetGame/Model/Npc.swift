//
//  Npc.swift
//  SetGame
//
//  Created by Илья Федорченко on 21/01/2019.
//  Copyright © 2019 Илья Федорченко. All rights reserved.
//

import Foundation

class SetSearcher: Game {
  
//  let cardPropertiesNumber = propertyValueRange.count
  
//  init() {
//  }
  
  func calcThirdCard(card1: Card, card2: Card) -> Card?{
    let symbol =          2 * (card1.symbol + card2.symbol) % 3
    let color =           2 * (card1.color + card2.color) % 3
    let shading =         2 * (card1.shading + card2.shading) % 3
    let numberOfSymbols = 2 * (card1.numberOfSymbols + card2.numberOfSymbols) % 3
    let card3: Card?
    
    if let hashValue = getCardId(symbol: symbol, color: color, shading: shading, numberOfSymbols: numberOfSymbols) {
      card3 = Card(symbol: symbol, color: color, shading: shading, numberOfSymbols: numberOfSymbols, hashValue: hashValue)
      
      print("\(card1.hashValue) - \(card1.symbol) - \(card1.color) - \(card1.shading) - \(card1.numberOfSymbols)")
      print("\(card2.hashValue) - \(card2.symbol) - \(card2.color) - \(card2.shading) - \(card2.numberOfSymbols)")
      print("======================= Card 3 ========================")
      print("\(card3!.hashValue) - \(card3!.symbol) - \(card3!.color) - \(card3!.shading) - \(card3!.numberOfSymbols)")
      print("=======================================================\n")
      
    } else {
      card3 = nil
    }
    return card3
  }
  
  func createPairsCombinations(from cards: [Card]) -> [[Card]] {
    var cardsToTake = cards
    var pair: [Card]
    var pairs = [[Card]]()
    
    for _ in cardsToTake {
      let card1 = cardsToTake.removeFirst()
      for card2 in cardsToTake {
        if card1 != card2 {
          pair = [Card]()
          pair = [card1, card2]
          pairs.append(pair)
        }
      }
    }
    
    for pair in pairs.indices {
      print ("- Pair \(String(pair)):")
      for card in pairs[pair].indices {
        print ("--- Card \(String(card)): \(pairs[pair][card].hashValue)")
      }
    }
    
    return pairs
  }
  
  
  //  func getAllSets() -> Matrix? {
  //
  //  }
  //
  //  func getSetHint() -> Int? {
  //
  //  }
  //
  //  func getRandomSet() -> [Int]? {
  //
  //  }
  
}

