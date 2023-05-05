//
//  ViewController.swift
//  EggTimer
//
//  Created by Vitali Schumarov on 03.05.23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var counterLabel: UILabel!
    
    let softTime: Int = 10
    let mediumTime: Int = 15
    let hardTime: Int = 20
    var counter: Int = 0
    var eggAlreadyCooked: Bool = false
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.0
        
    }
    
    @IBAction func pressedEgg(_ sender: UIButton) {
        if (eggAlreadyCooked == false) {
            eggAlreadyCooked = true
            progressBar.progress = 0.0
            counter = 0
            if (sender.currentTitle! == "hard") {
                startTimer(hardTime)
            } else if (sender.currentTitle! == "medium") {
                startTimer(mediumTime)
            } else {
                startTimer(softTime)
            }
        } else {
            progressBar.progress = 0.0
            counter = 0
        }
       
    }
    
    func startTimer(_ typeOfEgg: Int) {
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            print(self.counter)
            self.counterLabel.text = String(typeOfEgg - self.counter)
            self.counter += 1
            self.updateProgressbar(updateCounter: self.counter, hardness: typeOfEgg)
            if (self.counter > typeOfEgg) {
                print("egg is ready")
                timer.invalidate()
                self.playSound()
                self.counter = 0
            }
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
    
    func updateProgressbar(updateCounter: Int, hardness: Int) {
        var newCounter = Float(updateCounter)
        var newHardness = Float(hardness)
        progressBar.progress = newCounter / newHardness
    }
}
