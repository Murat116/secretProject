//
//  GameView.swift
//  Wins
//
//  Created by Мурат Камалов on 20.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import UIKit
import AVFoundation
import Speech

class GameView: UIView{
    
    private var speechRecognitionIsAvialable = true
    
    private let synthesizer = AVSpeechSynthesizer()
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    deinit {
        print("GameView deinit")
    }
    
    private var yesBtn = UIButton()
    private var noBtn = UIButton()
    
    internal var infoBtn = UIButton()
    private var speechSwitch = UISwitch()
    private var speechLabel = UILabel()
    
    private var trickLabel = UILabel()
    
    private var trickCountLabel = UILabel()
    private var progressBar = UIProgressView()
    
    private var trickCount: Int = 0
    
    private var tricks = [Trick]()
    private var chalenges = [Challenge]()
    
    internal var output: GameViewViewOutput!
    
    @objc func back(){
        let alert = UIAlertController(title: "U want to stop game?", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Stay to play", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Stop game!", style: .destructive, handler: { (_) in
            self.removeFromSuperview()
        }))
        RootViewController._shared.present(alert, animated: true, completion: nil)
    }
    
    @objc func nextTrick(btn: UIButton){
        
        let oldTrick = self.tricks[self.trickCount]
        var stab = oldTrick.stability
        var dif = oldTrick.complexity
        if self.noBtn != btn {
            stab += 1
            dif -= 0.3
            
            if let challenge = self.chalenges.first(where: {$0.trick_name == oldTrick.name}){
                self.output.isChallengeDone(challenge, done: true)
            }
        }else{
            stab -= 1
            dif += 0.3
        }
        self.output.saveChanges(of: oldTrick, with: dif, and: stab)
        
        self.trickCount += 1
        guard self.trickCount < 10 else {
            self.output.recountTechnocalSkill()
            UIView.animate(withDuration: 0.3) {
                self.removeFromSuperview()
            }
            return
        }
        
        self.progressBar.progress = Float(self.trickCount + 1) / 10
        
        self.trickCountLabel.text = "\(self.trickCount + 1)/10"
        
        let trick = self.tricks[self.trickCount]
        
        self.trickLabel.text = trick.name
        
        synthesizer.stopSpeaking(at: .immediate)
        
        self.stopRecognition()
        
        recordAndRecognizeSpeech()
        
        self.output.speekTrick()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        guard newSuperview == nil else { return }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "gameViewWillRemove"), object: nil, userInfo: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        self.addSubview(blur)
        blur.translatesAutoresizingMaskIntoConstraints = false
        blur.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        blur.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        blur.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        blur.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        blur.alpha = 1.0
        
        let backView = UIView()
        self.addSubview(backView)
        backView.frame = self.frame
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.back))
        backView.addGestureRecognizer(tap)
        
        let playView = UIView()
        self.addSubview(playView)
        
        self.addSubview(self.trickLabel)
        self.trickLabel.translatesAutoresizingMaskIntoConstraints = false
        self.trickLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 33).isActive = true
        self.trickLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -33).isActive = true
        self.trickLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        self.trickLabel.font = UIFont.systemFont(ofSize: 36)
        self.trickLabel.textColor = .white
        
        self.addSubview(self.yesBtn)
        self.yesBtn.translatesAutoresizingMaskIntoConstraints = false
        self.yesBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -33).isActive = true
        self.yesBtn.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 5).isActive = true
        self.yesBtn.topAnchor.constraint(equalTo: self.trickLabel.bottomAnchor, constant: 40).isActive = true
        self.yesBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.yesBtn.addTarget(self, action: #selector(self.nextTrick(btn:)), for: .touchUpInside)
        
        self.yesBtn.backgroundColor = UIColor(hex: "214FEF")
        self.yesBtn.layer.cornerRadius = 6
        self.yesBtn.setTitle("Yes", for: [])
        self.yesBtn.setTitleColor(.white, for: [])
        
        self.addSubview(self.noBtn)
        self.noBtn.translatesAutoresizingMaskIntoConstraints = false
        self.noBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant:  33).isActive = true
        self.noBtn.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -5).isActive = true
        self.noBtn.topAnchor.constraint(equalTo: self.trickLabel.bottomAnchor, constant: 40).isActive = true
        self.noBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.noBtn.backgroundColor = UIColor(hex: "214FEF")
        self.noBtn.layer.cornerRadius = 6
        self.noBtn.setTitle("No", for: [])
        self.noBtn.setTitleColor(.white, for: [])
        
        self.noBtn.addTarget(self, action: #selector(self.nextTrick(btn:)), for: .touchUpInside)
        
        self.addSubview(self.trickCountLabel)
        self.trickCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.trickCountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -38).isActive = true
        self.trickCountLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        self.trickCountLabel.font = UIFont.systemFont(ofSize: 14)
        self.trickCountLabel.textColor = UIColor(hex: "909090")
        self.trickCountLabel.text = "1/10"
        
        self.addSubview(self.progressBar)
        self.progressBar.translatesAutoresizingMaskIntoConstraints = false
        self.progressBar.bottomAnchor.constraint(equalTo: self.trickLabel.topAnchor, constant: -40).isActive = true
        self.progressBar.rightAnchor.constraint(equalTo: self.rightAnchor, constant:  -33).isActive = true
        self.progressBar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 33).isActive = true
        
        
        self.progressBar.progressTintColor = UIColor(hex: "214FEF")
        self.progressBar.progress = 0.1
        self.progressBar.backgroundColor = UIColor(hex: "C4C4C4")
        
        self.addSubview(self.speechSwitch)
        self.speechSwitch.translatesAutoresizingMaskIntoConstraints = false
        self.speechSwitch.topAnchor.constraint(equalTo: self.noBtn.bottomAnchor, constant: 28).isActive = true
        self.speechSwitch.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -33).isActive = true
        self.speechSwitch.isOn = false
        self.speechSwitch.addTarget(self, action: #selector(self.changeSpeechState), for: .touchUpInside)
        
        
        self.addSubview(self.infoBtn)
        self.infoBtn.translatesAutoresizingMaskIntoConstraints = false
        self.infoBtn.topAnchor.constraint(equalTo: self.noBtn.bottomAnchor, constant: 28).isActive = true
        self.infoBtn.rightAnchor.constraint(equalTo: self.speechSwitch.leftAnchor, constant: -13).isActive = true
        self.infoBtn.heightAnchor.constraint(equalTo: self.speechSwitch.heightAnchor, constant: 0).isActive = true
        self.infoBtn.widthAnchor.constraint(equalTo: self.speechSwitch.heightAnchor, constant: 0).isActive = true
        
        self.infoBtn.addTarget(self, action: #selector(self.infoTapped), for: .touchUpInside)
        
        self.infoBtn.tintColor = UIColor(hex: "FFFFFF")
        self.infoBtn.setTitle("?", for: .normal)
        self.infoBtn.setTitleColor(UIColor(hex: "909090"), for: .normal)
        self.infoBtn.setBackgroundImage(UIImage(systemName: "circle.fill"), for: .normal)
        
        
        self.addSubview(self.speechLabel)
        self.speechLabel.translatesAutoresizingMaskIntoConstraints = false
        self.speechLabel.topAnchor.constraint(equalTo: self.speechSwitch.topAnchor, constant: 0).isActive = true
        self.speechLabel.rightAnchor.constraint(equalTo: self.infoBtn.leftAnchor, constant: -15).isActive = true
        self.speechLabel.centerYAnchor.constraint(equalTo: self.infoBtn.centerYAnchor, constant: 0).isActive = true
        
        self.speechLabel.text = "Speech control"
        self.speechLabel.textColor = UIColor(hex: "909090")
        self.speechLabel.font = UIFont.systemFont(ofSize: 14)
        
        self.layoutIfNeeded()
        
        let y = self.progressBar.frame.origin.y
        let height = self.speechLabel.frame.maxY
        
        playView.frame = CGRect(x: 0, y: y - 20, width: self.frame.width, height: height + 40 - y)
    }
}

extension GameView: GameViewViewInput{
    
    func configure(with tenTricks: [Trick], _ actualChallenges: [Challenge]) {
        self.tricks = tenTricks
        self.trickLabel.text = tenTricks[0].name
        self.chalenges = actualChallenges
        self.output.speekTrick()
        self.speechRecognizer?.delegate = self
        self.recordAndRecognizeSpeech()
    }
    
    @objc func infoTapped() {
        self.output.infoTapped()
    }
    
    @objc func speechOn(){
        
    }
}

extension GameView {
    
    func speekTrick () {
        guard let trick = trickLabel.text else { return }
        if speechSwitch.isOn {
            let utterance = AVSpeechUtterance(string: trick)
            utterance.rate = 0.5
            utterance.volume = 1.0
            
            synthesizer.speak(utterance)
        }
    }
    @objc func changeSpeechState() {
        if self.speechSwitch.isOn {
            self.speekTrick()
            self.stopRecognition()
            self.recordAndRecognizeSpeech()
        } else {
            stopRecognition()
        }
        
        
    }
}
extension GameView: SFSpeechRecognizerDelegate {
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            self.speechRecognitionIsAvialable = true
        } else {
            self.speechRecognitionIsAvialable = false
        }
    }
    func recordAndRecognizeSpeech() {
        guard self.speechSwitch.isOn else {
            stopRecognition()
            return
        }
        if let recognitionTask = self.recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
          }
          self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
          guard let recognitionRequest = self.recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }
          let inputNode = audioEngine.inputNode
          recognitionRequest.shouldReportPartialResults = true
        
        self.recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { result, error in
            if let result = result {
                let str = result.bestTranscription.formattedString
                var lastWord = ""
                for segment in result.bestTranscription.segments {
                    let index = str.index(str.startIndex, offsetBy: segment.substringRange.location)
                    lastWord = String(str[index...])
                }
                switch lastWord.capitalized {
                case "Yes":
                    self.nextTrick(btn: self.yesBtn)
                case "No":
                    self.nextTrick(btn: self.noBtn)
                default: break
                }
            }
          })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        inputNode.installTap(onBus: 0, bufferSize: 2048, format: recordingFormat, block: { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            recognitionRequest.append(buffer)
          })
        
          self.audioEngine.prepare()
        do {
            try self.audioEngine.start()
        } catch {
            return
        }
               
    }
    func stopRecognition() {
        self.recognitionTask?.finish()
        self.recognitionTask = nil
        self.recognitionRequest?.endAudio()
        self.audioEngine.stop()
        self.audioEngine.inputNode.removeTap(onBus: 0)
    }
}

extension GameView: UIPopoverPresentationControllerDelegate{
    //UIPopoverPresentationControllerDelegate inherits from UIAdaptivePresentationControllerDelegate, we will use this method to define the presentation style for popover presentation controller
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    //UIPopoverPresentationControllerDelegate
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    
}
