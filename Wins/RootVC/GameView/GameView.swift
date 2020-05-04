//
//  GameView.swift
//  Wins
//
//  Created by Мурат Камалов on 20.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import UIKit

class GameView: UIView{
    
    private var yesBtn = UIButton()
    private var noBtn = UIButton()
    
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
                    
                    if let challenge = self.chalenges.first(where: {$0.trick?.name == oldTrick.name}){
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
        
        blur.alpha = 0.9
        
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
        self.yesBtn.setTitle("Done", for: [])
        self.yesBtn.setTitleColor(.white, for: [])
        
        self.addSubview(self.noBtn)
        self.noBtn.translatesAutoresizingMaskIntoConstraints = false
        self.noBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant:  33).isActive = true
        self.noBtn.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -5).isActive = true
        self.noBtn.topAnchor.constraint(equalTo: self.trickLabel.bottomAnchor, constant: 40).isActive = true
        self.noBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.noBtn.backgroundColor = UIColor(hex: "214FEF")
        self.noBtn.layer.cornerRadius = 6
        self.noBtn.setTitle("Fail", for: [])
        self.noBtn.setTitleColor(.white, for: [])
        
        self.noBtn.addTarget(self, action: #selector(self.nextTrick(btn:)), for: .touchUpInside)
        
        self.addSubview(self.trickCountLabel)
        self.trickCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.trickCountLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 33).isActive = true
        self.trickCountLabel.bottomAnchor.constraint(equalTo: self.trickLabel.topAnchor, constant: -40).isActive = true
        
        self.trickCountLabel.font = UIFont.systemFont(ofSize: 14)
        self.trickCountLabel.textColor = UIColor(hex: "505050")
        self.trickCountLabel.text = "1/10"
        
        self.addSubview(self.progressBar)
        self.progressBar.translatesAutoresizingMaskIntoConstraints = false
        self.progressBar.rightAnchor.constraint(equalTo: self.rightAnchor, constant:  0).isActive = true
        self.progressBar.leftAnchor.constraint(equalTo: self.trickCountLabel.rightAnchor, constant: 10).isActive = true
        self.progressBar.centerYAnchor.constraint(equalTo: self.trickCountLabel.centerYAnchor).isActive = true
        
        self.progressBar.progressTintColor = UIColor(hex: "214FEF")
        self.progressBar.progress = 0.1
        self.progressBar.backgroundColor = UIColor(hex: "C4C4C4")
    
        self.layoutIfNeeded()
        
        let y = self.trickCountLabel.frame.origin.y
        let height = self.yesBtn.frame.maxY - y
        
        playView.frame = CGRect(x: 0, y: y - 20, width: self.frame.width, height: height + 20)
    }
}

extension GameView: GameViewViewInput{
    func configure(with tenTricks: [Trick], _ actualChallenges: [Challenge]) {
        self.tricks = tenTricks
        self.trickLabel.text = tenTricks[0].name
        self.chalenges = actualChallenges
    }
}
