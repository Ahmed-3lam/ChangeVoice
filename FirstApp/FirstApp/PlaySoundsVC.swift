//
//  RecordingFinished.swift
//  FirstApp
//
//  Created by Ahmed Allam on 03/06/2021.
//

import UIKit
import AVFoundation


class PlaySoundsVC:UIViewController {
    var recordedAudioUrl : URL!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    
    @IBOutlet weak var reverbButton: UIButton!
    var recordedAudioURL:URL!
    
    @IBOutlet weak var vaderButton: UIButton!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio() 

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    
    }
    
    @IBAction func playingSounds(_ sender: UIButton){
        switch(ButtonType(rawValue: sender.tag)!) {
         case .slow:
             playSound(rate: 0.5)
         case .fast:
             playSound(rate: 1.5)
         case .chipmunk:
             playSound(pitch: 1000)
         case .vader:
             playSound(pitch: -1000)
         case .echo:
             playSound(echo: true)
         case .reverb:
             playSound(reverb: true)
         }

         configureUI(.playing)
    }

    @IBAction func stopButton(_ sender: Any) {
        stopAudio()
    }
    
}
