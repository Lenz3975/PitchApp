//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by ChrisMac on 05.10.16.
//  Copyright © 2016 ChrisMac. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var darthVaderButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
   
    @IBOutlet weak var TopStack: UIStackView!
    @IBOutlet weak var MiddleStack: UIStackView!
    @IBOutlet weak var BottomStack: UIStackView!
    @IBOutlet weak var StopStack: UIStackView!
    @IBOutlet weak var ContainerStack: UIStackView!
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int { case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb}
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        print("Play Sound Button Pressed")
        switch (ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .Vader:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }
        
        configureUI(playState: .Playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        print("Stop Audio Button Pressed")
        stopAudio()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(playState: .NotPlaying)
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let orientation = UIApplication.shared.statusBarOrientation
        if orientation.isLandscape{
            ContainerStack.axis = .vertical
            changeAxleAlign(axleAlign: .horizontal)
        } else {
            ContainerStack.axis = .horizontal
            changeAxleAlign(axleAlign: .vertical)
        }
        
    }
    
    private func changeAxleAlign(axleAlign: UILayoutConstraintAxis) {
        TopStack.axis = axleAlign
        MiddleStack.axis = axleAlign
        BottomStack.axis = axleAlign
        StopStack.axis = axleAlign
    }
 
}
