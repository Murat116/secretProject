//
//  Registration.swift
//  Wins
//
//  Created by Мурат Камалов on 16.03.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import UIKit

class Registration: UIViewController{
    private var cross = UILabel()
    private var steps = UILabel()
    private var progressBar = UIProgressView()
    private var titleVC = UILabel()

    var stepsType: Steps = .sport

    var bottomAnchorTitle: NSLayoutYAxisAnchor? = nil

    static func show(steps: Steps, from parent: UIViewController){
        let instanse = Registration()
        instanse.stepsType = steps
        parent.present(instanse, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.configure(step: self.stepsType)
    }

    func setUp(){
        self.view.addSubview(self.cross)
        self.view.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)

        self.cross.translatesAutoresizingMaskIntoConstraints = false
        self.cross.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 33).isActive = true
        self.cross.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        self.cross.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.cross.heightAnchor.constraint(equalTo: self.cross.widthAnchor).isActive = true

        self.cross.text = "+"
        self.cross.font = UIFont.systemFont(ofSize: 30)
        self.cross.textColor = .white

        self.cross.transform = CGAffineTransform(rotationAngle: .pi / 4)

        self.view.addSubview(self.steps)
        self.view.addSubview(self.progressBar)
        self.steps.translatesAutoresizingMaskIntoConstraints = false
        self.steps.leftAnchor.constraint(equalTo: self.cross.rightAnchor, constant: 39).isActive = true
        self.steps.rightAnchor.constraint(equalTo: self.progressBar.leftAnchor, constant: -10).isActive = true
        self.steps.centerYAnchor.constraint(equalTo: self.cross.centerYAnchor).isActive = true

        self.steps.textColor = UIColor(red: 0.314, green: 0.314, blue: 0.314, alpha: 1)
        self.steps.font = UIFont.systemFont(ofSize: 14)


        self.progressBar.translatesAutoresizingMaskIntoConstraints = false
        self.progressBar.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.progressBar.centerYAnchor.constraint(equalTo: self.cross.centerYAnchor).isActive = true
        self.progressBar.widthAnchor.constraint(greaterThanOrEqualToConstant: 220).isActive = true

        self.progressBar.progressTintColor = UIColor(red: 0.129, green: 0.31, blue: 0.937, alpha: 1)

        self.view.addSubview(self.titleVC)
        self.titleVC.translatesAutoresizingMaskIntoConstraints = false
        self.titleVC.topAnchor.constraint(equalTo: self.cross.bottomAnchor, constant: 31).isActive = true
        self.titleVC.leftAnchor.constraint(equalTo: self.cross.leftAnchor).isActive = true
        self.titleVC.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 33).isActive = true

        self.bottomAnchorTitle = self.titleVC.bottomAnchor

        self.titleVC.font = UIFont.systemFont(ofSize: 36)
        self.titleVC.textColor = .white

        self.titleVC.lineBreakMode = .byWordWrapping
        self.titleVC.numberOfLines = 2

    }

    func configure(step: Steps){
        self.steps.text = step.text
        self.progressBar.progress = step.rawValue
        self.titleVC.text = step.title
    }
}

enum Steps: Float, CaseIterable{
    case sport = 0.33
    case userInfo = 0.66
    case tricks = 1.0

    var text: String{
        return "шаг \(Int(self.rawValue / 0.33))/3"
    }

    var title: String{
        switch self {
        case .sport:
            return "Вид спорта"
        case .userInfo:
            return "Введите данные"
        case .tricks:
            return "Какие трюки умеешь?"
        }
    }

    
}
