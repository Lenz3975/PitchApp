//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by ChrisMac on 04.10.16.
//  Copyright © 2016 ChrisMac. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
  
    var audioRecorder:AVAudioRecorder!

    @IBAction func recordAudio(_ sender: AnyObject) {
        print("Record button pressed")
        setUIState(isRecording: true, recordingText: "Recording in Progress")

        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: AnyObject) {
        print("stop recording button pressed")
        setUIState(isRecording: false, recordingText: "Tab to record")
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)

    }
    
    func setUIState(isRecording:Bool, recordingText:String)
    {
        stopRecordingButton.isEnabled = (isRecording) ? true : false
        recordButton.isEnabled = (isRecording) ? false : true
        recordingLabel.text = recordingText

    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopRecordingButton.isEnabled = false
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("Finisch")
        if (flag) {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Saving of recording failed")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    
    }
}

