//
//  Character.swift
//  OOP Class RPGoop
//
//  Created by Neel Khattri on 7/22/16.
//  Copyright © 2016 SimpleStuff. All rights reserved.
//

import Foundation

class Character {
    
    private var _hp: Int = 100
    var hp: Int {
        get {
            return _hp
        }
    }
    
    private var _attackPower:Int = 15
    var attackPower: Int {
        get {
            return _attackPower
        }
    }
    
    func attemptAttack (attackPower:Int) {
        self._hp -= attackPower
    }
    
    func isAlive () -> Bool {
        if _hp <= 0 {
            return false
        }
        return true
    }
    
    init (startingHp: Int, attackPower: Int) {
        self._hp = startingHp
        self._attackPower = attackPower
    }
}
