//
//  ViewController.swift
//  FirstApp
//
//  Created by Ahmed Allam on 02/06/2021.
//

import UIKit
import AVFoundation

class FirstScreen: UIViewController,  AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    @IBOutlet weak var btnStopRecording: UIButton!
    @IBOutlet weak var btnRecord: UIButton!
    @IBOutlet weak var lblRecord: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnRecord(_ sender: Any) {
        lblRecord.text="you are recordnig"
        btnStopRecording.isEnabled=true
        btnRecord.isEnabled=false
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
               let recordingName = "recordedVoice.wav"
               let pathArray = [dirPath, recordingName]
               let filePath = URL(string: pathArray.joined(separator: "/"))

               let session = AVAudioSession.sharedInstance()
               try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

               try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
               audioRecorder.isMeteringEnabled = true
               audioRecorder.prepareToRecord()
               audioRecorder.record()
        
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        lblRecord.text="Press to record "
        btnStopRecording.isEnabled=false
        btnRecord.isEnabled=true
        audioRecorder.stop()
           let audioSession = AVAudioSession.sharedInstance()
           try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else{
          print("the recording isn't successful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundsVC = segue.destination as! PlaySoundsVC
            let recordedAudioUrl = sender as! URL
            playSoundsVC.recordedAudioUrl = recordedAudioUrl
            
        }
        
    }
}

