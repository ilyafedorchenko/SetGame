//
//  CardView.swift
//  SetGame
//
//  Created by Илья Федорченко on 17/01/2019.
//  Copyright © 2019 Илья Федорченко. All rights reserved.
//

import UIKit

struct CardView {
  let index: Int
  let title: NSAttributedString
  
  private let colors = [#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1),#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1),#colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)]
  private let symbols = ["▲","●","■"]
  private let shadings = ["Solid","Striped","Outlined"]
  private let numbers = [1,2,3]

  init(hashValue: Int, symbol: Int, color: Int, shading: Int, number: Int) {
    self.index = hashValue
    
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
        NSAttributedString.Key.backgroundColor : #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),
        NSAttributedString.Key.foregroundColor : colors[color]
//        NSAttributedString.Key.foregroundColor : colors[color].withAlphaComponent(0.50)
        ]
      self.title = NSAttributedString(string: title, attributes: attributes)
    case "Outlined":
      let attributes: [NSAttributedString.Key:Any] = [
        NSAttributedString.Key.strokeWidth : 10.0,
        NSAttributedString.Key.strokeColor : colors[color],
      ]
      self.title = NSAttributedString(string: title, attributes: attributes)
    default:
      self.title = NSAttributedString(string: "")
    }
    
  }

}
