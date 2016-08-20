//
//  PlaySoundsVC.swift
//  PitchPerfect
//
//  Created by David Moeller on 20/08/16.
//
//

import UIKit
import AVFoundation

class PlaySoundsVC: UIViewController {
	
	var filePath: NSURL?
	var audioFile: AVAudioFile!
	var audioEngine: AVAudioEngine!
	var audioPlayerNode: AVAudioPlayerNode!
	var stopTimer = NSTimer()
	
	@IBOutlet weak var reverbButton: UIButton!
	@IBOutlet weak var echoButton: UIButton!
	@IBOutlet weak var vaderButton: UIButton!
	@IBOutlet weak var chipmunkButton: UIButton!
	@IBOutlet weak var snailButton: UIButton!
	@IBOutlet weak var rabbitButton: UIButton!
	@IBOutlet weak var stopButton: UIButton!
	
	enum ButtonType: Int { case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb }

    override func viewDidLoad() {
        super.viewDidLoad()
		self.setupAudio()
        // Do any additional setup after loading the view.
    }
	
	override func viewWillAppear(animated: Bool) {
		configureUI(.NotPlaying)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func playSoundForButton(sender: UIButton) {
		print("Touched Button")
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
		
		configureUI(.Playing)
		
	}
	
	@IBAction func stopButtonPressed(sender: AnyObject) {
		stopAudio()
	}
     

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	
	

}
