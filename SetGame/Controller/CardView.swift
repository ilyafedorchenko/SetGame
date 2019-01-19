//
//  CardView.swift
//  SetGame
//
//  Created by Илья Федорченко on 17/01/2019.
//  Copyright © 2019 Илья Федорченко. All rights reserved.
//

import UIKit

struct CardView:Equatable {
  let hashValue: Int
  let title: NSAttributedString
  var state: CardState
  var buttonId: Int? = nil
  
  private let colors = [#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1),#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1),#colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)]
  private let symbols = [" ▲ "," ● "," ■ "]
  private let shadings = ["Solid","Striped","Outlined"]
  private let numbers = [1,2,3]

  init(hashValue: Int, symbol: Int, color: Int, shading: Int, number: Int, state: CardState) {
    self.hashValue = hashValue
    self.state = state
    
    var title = ""
    for _ in 1...numbers[number]{
      title += symbols[symbol]
    }
    
    switch shadings[shading]{
    case "Solid":
      let attributes: [NSAttributedString.Key:Any] = [
        NSAttributedString.Key.foregroundColor : colors[color]
        ]
      self.title = NSAttributedString(string: title, attributes: attributes)
    case "Striped":
      let attributes: [NSAttributedString.Key:Any] = [
        NSAttributedString.Key.backgroundColor : colors[color],
        NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        ]
      self.title = NSAttributedString(string: title, attributes: attributes)
    case "Outlined":
      let attributes: [NSAttributedString.Key:Any] = [
        NSAttributedString.Key.strokeWidth : 15.0,
        NSAttributedString.Key.strokeColor : colors[color],
      ]
      self.title = NSAttributedString(string: title, attributes: attributes)
    default:
      self.title = NSAttributedString(string: "")
    }
    
  }

}
