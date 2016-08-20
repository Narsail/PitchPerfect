//
//  ViewController.swift
//  PitchPerfect
//
//  Created by David Moeller on 20/08/16.
//
//

import UIKit
import AVFoundation

class RecordSoundsVC: UIViewController, AVAudioRecorderDelegate {

	@IBOutlet weak var recordingButton: UIButton!
	@IBOutlet weak var stopRecordingButton: UIButton!
	
	@IBOutlet weak var recordingLabel: UILabel!
	
	var audioRecorder: AVAudioRecorder?
	
	var filePath: NSURL?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.stopRecordingButton.enabled = false
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let vc = segue.destinationViewController as? PlaySoundsVC {
			vc.filePath = self.filePath
		}
	}

	@IBAction func record(sender: AnyObject) {
		
		do {
			// Recording Action
			let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
			let recordingName = "recordedVoice.wav"
			let pathArray = [dirPath, recordingName]
			guard let filePath = NSURL.fileURLWithPathComponents(pathArray) else {
				self.recordingLabel.text = "Filepath of Item to record not found"
				return
			}
			
			self.filePath = filePath
			
			let session = AVAudioSession.sharedInstance()
			
			try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
			
			try audioRecorder = AVAudioRecorder(URL: filePath, settings: [:])
			audioRecorder?.delegate = self
			audioRecorder?.meteringEnabled = true
			audioRecorder?.prepareToRecord()
			audioRecorder?.record()
			
			self.recordingLabel.text = "Recording in Progress"
			self.recordingButton.enabled = false
			self.stopRecordingButton.enabled = true
		} catch {
			self.recordingLabel.text = "Sry. An Error occurred: \(error)"
			return
		}
	}

	@IBAction func stopRecording(sender: AnyObject) {
		self.recordingLabel.text = "Tap to record."
		self.recordingButton.enabled = true
		self.stopRecordingButton.enabled = false
		
		audioRecorder?.stop()
		let audioSession = AVAudioSession.sharedInstance()
		do {
			try audioSession.setActive(false)
		} catch {
			self.recordingLabel.text = "Sry. An Error occurred: \(error)"
			return
		}
	}
	
	func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
		if flag {
			self.performSegueWithIdentifier("playSounds", sender: self)
		} else {
			self.recordingLabel.text = "Couldn't finish recording due to an internal error."
		}
	}
	
}

