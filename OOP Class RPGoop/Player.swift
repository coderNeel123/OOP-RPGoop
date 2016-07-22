//
//  Player.swift
//  OOP Class RPGoop
//
//  Created by Neel Khattri on 7/22/16.
//  Copyright © 2016 SimpleStuff. All rights reserved.
//

import Foundation

class Player: Character {
    
    private var _name: String = "Player"
    var name: String {
        get {
            return _name
        }
    }
    
    convenience init(startingHp: Int, attackPower: Int, name: String) {
        self.init(startingHp: startingHp, attackPower: attackPower)
        _name = name
    }
 }