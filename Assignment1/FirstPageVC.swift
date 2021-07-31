//
//  ViewController.swift
//  Assignment1
//
//  Created by Drashti Akbari on 2020-02-11.
//  Copyright © 2020 Drashti Akbari. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftGifOrigin
import JJFloatingActionButton

class FirstPageVC: UIViewController {

    // MARK:- Variables & Outlets
    
    @IBOutlet weak var coins: UILabel!
    @IBOutlet weak var randomNumber: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var timer : UILabel!
    @IBOutlet weak var yourGuess: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var replay: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var tryAgain: UIButton!
    @IBOutlet weak var visualEffectView: UIView!
    @IBOutlet weak var viewComplete: UIView!
    @IBOutlet weak var gifLoad: UIImageView!
    
    var gameTimer = Timer()
    var seconds = 15
    var randomNum = 0
    var sliderValue = 0
    var differenceValue = 0
    var levelNum = 0
    var audio = AVAudioPlayer()
    var audio1 = AVAudioPlayer()
    var sound1 = AVAudioPlayer()
    var audioTime = 5
    var audioTimer = Timer()
    var sound = 0
    var points = 0
    var tryCheck = 0
    var totalCoins = 0
    let btnAvtar = JJFloatingActionButton()
    var arrOfPic = [UIImage(named: "thumbImg"),UIImage(named: "thumbImg1"),UIImage(named: "thumbImg2"),UIImage(named: "thumbImg3"),UIImage(named: "thumbImg4"),UIImage(named: "thumbImg5")]
    
    // MARK:- View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let i = UserDefaults.standard.value(forKey: "thumb") as! Int
        slider.setThumbImage(arrOfPic[i], for: .normal)
        viewComplete.isHidden = true
        btnReset.isEnabled = false
        
        levelNum = UserDefaults.standard.value(forKey: "levelNum") as! Int
        level.text = "Level \(levelNum)"
        totalCoins = UserDefaults.standard.value(forKey: "totalCoins") as! Int
        coins.text = "\(totalCoins)"
        print(UserDefaults.standard.value(forKey: "totalCoins") as Any)
        
        tapGasture()
        btnAnimation()
        timeOverTune()
    }
    
    // MARK:- Functions
    
    func tapGasture() {
        let clickUITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onSelect(_:)))
        clickUITapGestureRecognizer.delegate = self as? UIGestureRecognizerDelegate
        visualEffectView?.addGestureRecognizer(clickUITapGestureRecognizer)
    }
    
    
       @IBAction func onSelect(_ sender: Any) {
           visualEffectView.isHidden = true
           audio1.play()
           coins.isHidden = true
       }
    
    func btnAnimation() {
        btnAvtar.addItem(title: "Home", image: UIImage(named: "home")) { item in
          
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "FirstPageVC") as! FirstPageVC
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        btnAvtar.addItem(title: "Sound", image: UIImage(named: "soundon")) { item in
          
            self.sound += 1
            if self.sound == 1 {
                item.buttonImage = UIImage(named: "soundoff")
                self.audio.volume = 0
                self.audio1.volume = 0
                self.audioTimer.invalidate()
                self.audio.stop()
                
            }
            else {
                item.buttonImage = UIImage(named: "soundon")
                self.audio.volume = 1
                self.audio1.volume = 1
                self.sound = 0
            }
        }

        btnAvtar.addItem(title: "Avtar", image: UIImage(named: "avtar")) { item in
            
            self.gameTimer.invalidate()
            self.audioTimer.invalidate()
            self.audio.stop()
            self.sound1.stop()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "AvtarVC") as! AvtarVC
            self.navigationController?.pushViewController(controller, animated: true)
        }

        btnAvtar.addItem(title: "Info", image: UIImage(named: "about")) { item in
          
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsVC
            self.navigationController?.pushViewController(controller, animated: true)
        }

        view.addSubview(btnAvtar)
        
        btnAvtar.translatesAutoresizingMaskIntoConstraints = false
        btnAvtar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        btnAvtar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
    }
    
    func timeOverTune() {
        do
        {
            let audioPath = Bundle.main.path(forResource: "GameOver", ofType: ".mp3")
            try audio = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            
        }
        catch
        {
            //ERROR
        }
    }
    
    func countDown() {
        slider.value = 50
        seconds = 15
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counter), userInfo: nil, repeats: true)
    }
    
    func audioStop() {
        audioTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counter1), userInfo: nil, repeats: true)
    }
    
    @objc func counter1() {
        audioTime -= 1
        
        if audioTime == 0 || seconds == 0 {
            audioTimer.invalidate()
            audio.stop()
            gameOver()
        }
    }
    
    @objc func counter() {
        seconds -= 1
        timer.text = String(seconds)
        
        if seconds == 0 {
            gameTimer.invalidate()
            audio1.stop()
        }
        if seconds == 5 {
            audio.play()
            audioStop()
        }
    }
    
    func differenceBetweenNumbers(a: Int, b:Int) -> (Int) {
      return a - b
    }
    
    func mathOperation(someFunc:  (Int, Int) -> Int, a: Int, b: Int) ->  (Int) {
        return  someFunc(a, b)
    }
    
    func levelComplete() {
        viewComplete.isHidden = false
        gifLoad.isHidden = false
        replay.isHidden = false
        btnNext.isHidden = false
        tryAgain.isHidden = true
        yourGuess.text = "Your Guess is \(Int(slider.value))\n You earn \(points) coins\n Your Total Score is \(totalCoins + points)"
        yourGuess.font = yourGuess.font.withSize(20)
        
    }
    
    func tryAgain1() {
        viewComplete.isHidden = false
        gifLoad.isHidden = true
        replay.isHidden = true
        btnNext.isHidden = true
        tryAgain.isHidden = false
        yourGuess.text = "Your Guess is \(Int(slider.value))\n You earn \(points) coins"
        yourGuess.font = yourGuess.font.withSize(20)
    }
    
    func gameOver() {
        viewComplete.isHidden = false
        gifLoad.isHidden = true
        replay.isHidden = true
        btnNext.isHidden = true
        tryAgain.isHidden = false
        yourGuess.text = "☹️"
        yourGuess.font = yourGuess.font.withSize(50)
    }
    
    func Variation() {
        switch differenceValue {
        case 0:
            points = 50
            levelComplete()
            break
            
        case 1,-1:
            points = 40
            levelComplete()
            break
            
        case 2,-2:
            points = 30
            levelComplete()
            break
            
        case 3,-3:
            points = 20
            levelComplete()
            break
            
        case 4,-4:
            points = 10
            levelComplete()
            break
            
        default:
            points = 0
            tryAgain1()
            break
                
        }
        
    }
    
    func bgTune() {
        let path = Bundle.main.path(forResource: "mario", ofType: "mp3")!
            let url = URL(fileURLWithPath: path)
        do {
            if sound == 0 {
                sound1 = try AVAudioPlayer(contentsOf: url)
                audio1 = sound1
                sound1.play()
            }
            
        } catch {
            //
        }
    }
    
    // MARK:- Buttons
    
    @IBAction func btnCheck(_ sender: UIButton) {
        if let text = btnCheck.titleLabel?.text {
            if text == "Try" || sender.tag == 10 {
                
                btnCheck.setTitle("Check", for: .normal)
                bgTune()
                btnReset.isEnabled = true
                
                viewComplete.isHidden = true
                gameTimer.invalidate()
                
                randomNum = Int.random(in: 0 ... 100)
                randomNumber.text = String(randomNum)
                
                countDown()
                
                if sender.tag == 10 {
                    totalCoins = UserDefaults.standard.value(forKey: "totalCoins") as! Int
                    totalCoins += points
                    UserDefaults.standard.set(totalCoins, forKey: "totalCoins")
                    
                    levelNum = UserDefaults.standard.value(forKey: "levelNum") as! Int
                    levelNum += 1
                    level.text = "Level \(levelNum)"
                    UserDefaults.standard.set(levelNum, forKey: "levelNum")
                }
                
            }
            else {
                gifLoad.loadGif(name: "fireworks")
                audio.stop()
                gameTimer.invalidate()
                
                differenceValue = mathOperation(someFunc: differenceBetweenNumbers, a: randomNum, b: sliderValue)
                
                Variation()
                
            }
        }
        
        
    }
    
    @IBAction func slider(_ sender: Any) {
        sliderValue = Int(slider.value)
    }
    
    @IBAction func reset(_ sender: Any) {
        bgTune()
        slider.value = 50
        sliderValue = 50
        btnCheck.isEnabled = true
        viewComplete.isHidden = true
        audio.stop()
        slider.addTapGesture()
        slider.setThumbImage(#imageLiteral(resourceName: "thumbImg"), for: .application)
        gameTimer.invalidate()
        countDown()
    }
   
}
    

