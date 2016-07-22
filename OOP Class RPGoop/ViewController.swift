//
//  ViewController.swift
//  OOP Class RPGoop
//
//  Created by Neel Khattri on 7/22/16.
//  Copyright © 2016 SimpleStuff. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var player1Hp: UILabel!
    
    @IBOutlet weak var player2Hp: UILabel!
    
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBOutlet weak var player2Image: UIImageView!
    
    @IBOutlet weak var player1Image: UIImageView!
    
    @IBOutlet weak var restartButton: UIButton!
    
    @IBOutlet weak var player1TextField: UITextField!
    
    @IBOutlet weak var player2TextField: UITextField!
    
    @IBOutlet weak var winningLabel: UILabel!
    
    var player1: Player!
    
    var player2: Player!
    
    var timer1: Int = 0
    
    var timer2: Int = 0
    
    var attackWait1: Int = 0
    
    var attackWait2: Int = 0
    
    var buttonSound = AVAudioPlayer()
    
    var buttonSound2 = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.player1TextField.delegate = self
        self.player2TextField.delegate = self

        
        player1 = Player(startingHp: 100, attackPower: 13, name: "Rocker1234")
        player2 = Player(startingHp: 115, attackPower: 17, name: "Gamer854")
        
        player1Hp.text = "\(player1.hp) HP"
        
        player2Hp.text = "\(player2.hp) HP"
        
        player1Image.hidden = false
        player2Image.hidden = false
        
        winningLabel.hidden = true
        
        restartButton.hidden = true
        
        
        // Attack Button
        let path = NSBundle.mainBundle().pathForResource("attack", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOfURL: soundUrl)
            buttonSound.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
        
        // Background Sound
        let path2 = NSBundle.mainBundle().pathForResource("geronimo", ofType: "m4a")
        let soundUrl2 = NSURL(fileURLWithPath: path2!)
        
        do {
            try buttonSound2 = AVAudioPlayer(contentsOfURL: soundUrl2)
            buttonSound2.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
        backgroundPlaySound()
        
    }
    
    @IBAction func player1AttackButtonPressed(sender: AnyObject) {
        player1Attacks()
    }

    @IBAction func player2AttackButtonPressed(sender: AnyObject) {
        player2Attacks()
    }
    
    @IBAction func restartButtonClicked(sender: AnyObject) {
        restartGame()
    }
    
    func player1Attacks () {
        if timer1 == 0 && attackWait1 == 0 && player1TextField.hidden == true && player2TextField.hidden == true {
        player2.attemptAttack(player1.attackPower)
        playSound()
        player2Hp.text = "\(player2.hp) HP"
        outputLabel.text = "Player 1 attacked Player 2 for \(player1.attackPower) HP"
        
        
        if !player2.isAlive() {
            playSound()
            player2Image.hidden = true
            player1Image.hidden = true
            player1Hp.hidden = true
            player2Hp.hidden = true
            winningLabel.text = "Player 1 Wins!"
            winningLabel.hidden = false
            restartButton.hidden = false
            outputLabel.text = "Congratulations Player 1"
            }
            
            timer2 = 3
            
            attackWait1 = 1
            
            NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.setTimer2To0), userInfo: nil, repeats: false)
            NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(ViewController.setAttackWait1To0), userInfo: nil, repeats: false)

        }
    }
    
    func player2Attacks () {
        if timer2 == 0 && attackWait2 == 0 && player1TextField.hidden == true && player2TextField.hidden == true{
        player1.attemptAttack(player2.attackPower)
        playSound()
        player1Hp.text = "\(player1.hp) HP"
        outputLabel.text = "Player 2 attacked Player 1 for \(player2.attackPower) HP"
            
        
        if !player1.isAlive() {
            playSound()
            player1Image.hidden = true
            player2Image.hidden = true
            player1Hp.hidden = true
            player2Hp.hidden = true
            winningLabel.text = "Player 2 Wins!"
            winningLabel.hidden = false
            restartButton.hidden = false
            outputLabel.text = "Congratulations Player 2"
            }
            
            timer1 = 3
            
            attackWait2 = 1
            
            NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector:#selector(ViewController.setTimer1To0), userInfo: nil, repeats: false)
            NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(ViewController.setAttackWait2To0)
                , userInfo: nil, repeats: false)
        }
    }
    
    
    func setTimer1To0 () {
        timer1 = 0
    }
    
    func setTimer2To0 () {
        timer2 = 0
    }
    
    func setAttackWait1To0 () {
        attackWait1 = 0
    }
    func setAttackWait2To0 () {
        attackWait2 = 0
    }
    
    func restartGame () {
        player1 = Player(startingHp: 100, attackPower: 12, name: "Rocker1234")
        player2 = Player(startingHp: 115, attackPower: 8, name: "Gamer854")
        
        player1Hp.text = "\(player1.hp) HP"
        player2Hp.text = "\(player2.hp) HP"
        
        player1Hp.hidden = false
        player2Hp.hidden = false
        
        player1Image.hidden = false
        player2Image.hidden = false
        
        winningLabel.hidden = true
        
        restartButton.hidden = true
        
        
         timer1 = 0
        
         timer2 = 0
        
         attackWait1 = 0
        
         attackWait2 = 0
        
        outputLabel.text = "Press Attack Button to Attack!"
        
        player1TextField.hidden = false
        player2TextField.hidden = false
        
    }
    
    func playSound () {
        if buttonSound.playing {
            buttonSound.stop()
        }
        buttonSound.play()
    }
    func backgroundPlaySound () {
        buttonSound2.play()
    }
    
    
    
    
    func player1TextFieldForImage () {
        if player1TextField.text == "orc" {
            player1Image.image = UIImage(named: "enemy")
        }
        else if player1TextField.text == "orc " {
            player1Image.image = UIImage(named: "enemy")
        }
        else if player1TextField.text == "Orc" {
            player1Image.image = UIImage(named: "enemy")
        }
        else if player1TextField.text == "Orc " {
            player1Image.image = UIImage(named: "enemy")
        }
        else if player1TextField.text == "soldier" {
            player1Image.image = UIImage(named: "player-flipped")
        }
        else if player1TextField.text == "soldier " {
            player1Image.image = UIImage(named: "player-flipped")
        }
        else if player1TextField.text == "Soldier" {
            player1Image.image = UIImage(named: "player-flipped")
        }
        else if player1TextField.text == "Soldier " {
            player1Image.image = UIImage(named: "player-flipped")
        }
        else {
            player1Image.image = UIImage(named: "enemy")
        }
        player1TextField.hidden = true
        player1TextField.text = ""
    }
    
    func player2TextFieldForImage () {
        if player2TextField.text == "orc" {
            player2Image.image = UIImage(named: "enemy-flipped")
        }
        else if player2TextField.text == "orc " {
            player2Image.image = UIImage(named: "enemy-flipped")
        }
        else if player2TextField.text == "Orc" {
            player2Image.image = UIImage(named: "enemy-flipped")
        }
        else if player2TextField.text == "Orc " {
            player2Image.image = UIImage(named: "enemy-flipped")
        }
        else if player2TextField.text == "soldier" {
            player2Image.image = UIImage(named: "player")
        }
        else if player2TextField.text == "Soldier" {
            player2Image.image = UIImage(named: "player")
        }
        else if player2TextField.text == "Soldier " {
            player2Image.image = UIImage(named: "player")
        }
        else {
            player2Image.image = UIImage(named: "player")
        }
        player2TextField.hidden = true
        player2TextField.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    func textFieldDidEndEditing(textField: UITextField){
        switch (textField) {
        case player1TextField:
            player1TextFieldForImage()
        case player2TextField:
            player2TextFieldForImage()
        default:
            print("Error")
        }
    }
    
    
    
}


