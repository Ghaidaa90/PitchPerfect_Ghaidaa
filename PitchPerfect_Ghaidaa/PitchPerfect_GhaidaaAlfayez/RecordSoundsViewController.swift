//
//  RecordSoundViewController.swift
//  PitchPerfect_GhaidaaAlfayez
//
//  Created by Ghaidaa Alfayez on 18/01/1441 AH.
//  Copyright © 1441 Udacity. All rights reserved.
//

import UIKit
import AVFoundation
class RecordSoundViewController: UIViewController,AVAudioRecorderDelegate {
    var audioRecorder:AVAudioRecorder!
    @IBOutlet weak var LabelTabtoRecord: UILabel!
    @IBOutlet weak var RecordButtonVar: UIButton!
    @IBOutlet weak var StopButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        StopButton.isEnabled=false
        // Do any additional setup after loading the view.
    }


    @IBAction func RecordButton(_ sender: UIButton) {
        LabelTabtoRecord.text="Recording"
        StopButton.isEnabled=true
        RecordButtonVar.isEnabled=false
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate=self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func StopRecordButton(_ sender: AnyObject) {
        RecordButtonVar.isEnabled=true
        StopButton.isEnabled=false
        LabelTabtoRecord.text="Tab to Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier:"stopRecording", sender: audioRecorder.url)
        }else{
        
            print("Recording was not successful")}
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="stopRecording" {
            let playSoundsVC=segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

