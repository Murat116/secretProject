//
//  UserInfoRegistration.swift
//  Wins
//
//  Created by Мурат Камалов on 16.03.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import UIKit

class UserInfoRegistrationVC: Registration{

    static func show(parent: UIViewController){
//        let instanse = UserInfoRegistration()
//        instanse.stepsType = .userInfo
//        parent.present(instanse, animated: true, completion: nil)
    }

    //----------------------------------------------------------------------

    var nameField = UserField()
    var cityFiled = UserField()
    var ageField = UserField()
    
    var stand = UISegmentedControl()

    //----------------------------------------------------------------------

    var avatarBtn = UIButton()
    var addAvatarBtn = UIButton()
    
    //----------------------------------------------------------------------
    
    let socNetLbl = UILabel()
    
    let faceBtn = UIButton()
    let instBtn = UIButton()
    let twitBtn = UIButton()
    
    //----------------------------------------------------------------------
    
    var nextVcBtn = UIButton()

    //----------------------------------------------------------------------
    
    var configurator: UserInfoRegConfiguratorProtocol = UserInfoRegConfigirator()
    var presenter: UserInfoRegPresenterProtocol!
    
    
    //----------------------------------------------------------------------


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configurator.configure(with: self)
        self.presenter.configureView()
    }
    
    override func setUp() {
        super.setUp()
        self.setUpUI()
    }

    
}

extension UserInfoRegistrationVC: UserInfoRegViewProtocol{
    func setUp(with step: Int) {
        self.stepsType = .userInfo
        self.configure(step: self.stepsType)
    }
}

extension UserInfoRegistrationVC{
    func setUpUI(){
        
        //переписать на что - то более гибкое
        self.textFiledSetUp(field: self.nameField, with: self.bottomAnchorTitle!,constant: 30, and: .name)
        self.textFiledSetUp(field: self.cityFiled, with: self.nameField.bottomAnchor, and: .city)
        self.textFiledSetUp(field: self.ageField, with: self.cityFiled.bottomAnchor, and: .age)

        self.stand = UISegmentedControl(items: ["Regular","Goofy"])
        
        self.view.addSubview(self.stand)
    
        self.stand.setTitle("Regular", forSegmentAt: 0)
        self.stand.setTitle("Goofy", forSegmentAt: 1)
        
        self.stand.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        
        self.stand.selectedSegmentTintColor = UIColor(red: 0.131, green: 0.309, blue: 0.939, alpha: 1)
        self.stand.tintColor = .red
        
        self.stand.backgroundColor = UIColor(red: 0.314, green: 0.314, blue: 0.314, alpha: 1)
    
        self.stand.translatesAutoresizingMaskIntoConstraints = false
        
        self.stand.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -33).isActive = true
        self.stand.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:  33).isActive = true
        self.stand.topAnchor.constraint(equalTo: self.ageField.bottomAnchor, constant:  15).isActive = true
        self.stand.heightAnchor.constraint(equalTo: self.ageField.heightAnchor).isActive = true
        //------------------
        
        self.view.addSubview(self.avatarBtn)
        self.avatarBtn.translatesAutoresizingMaskIntoConstraints = false
        self.avatarBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 33).isActive = true
        self.avatarBtn.topAnchor.constraint(equalTo: self.stand.bottomAnchor, constant: 26).isActive = true
        self.avatarBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.avatarBtn.widthAnchor.constraint(equalTo: self.avatarBtn.widthAnchor).isActive = true

        self.avatarBtn.layer.borderWidth = 1
        self.avatarBtn.layer.borderColor = UIColor(red: 0.314, green: 0.314, blue: 0.314, alpha: 1).cgColor

        let imageImage = UIImage(named: "Registration/avatar")?.withRenderingMode(.alwaysTemplate)
        self.avatarBtn.setImage(imageImage, for: .normal)
        self.avatarBtn.imageView?.tintColor = UIColor(red: 0.314, green: 0.314, blue: 0.314, alpha: 1.0)
        
        self.avatarBtn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8 )

        //------------------
        
        self.view.addSubview(self.addAvatarBtn)
        self.addAvatarBtn.translatesAutoresizingMaskIntoConstraints = false
        self.addAvatarBtn.leftAnchor.constraint(equalTo: self.avatarBtn.rightAnchor, constant: 22).isActive = true
        self.addAvatarBtn.centerYAnchor.constraint(equalTo: self.avatarBtn.centerYAnchor).isActive = true
        
        let attrs : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 19.0),
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.underlineStyle : 1]

        let buttonTitleStr = NSMutableAttributedString(string: "Download", attributes:attrs)
        
        self.addAvatarBtn.setAttributedTitle(buttonTitleStr, for: .normal)
        
        //------------------
        
        
        self.view.addSubview(socNetLbl)
        self.socNetLbl.translatesAutoresizingMaskIntoConstraints = false
        self.socNetLbl.leftAnchor.constraint(equalTo: self.avatarBtn.leftAnchor).isActive = true
        self.socNetLbl.topAnchor.constraint(equalTo: self.avatarBtn.bottomAnchor, constant: 32).isActive = true
        
        self.socNetLbl.font = UIFont.systemFont(ofSize: 18)
        self.socNetLbl.numberOfLines = 2
        self.socNetLbl.lineBreakMode = .byWordWrapping
        
        self.socNetLbl.text = "Add social\nnetwork"
        self.socNetLbl.textColor = .white
        
        self.view.addSubview(self.twitBtn)
        self.twitBtn.translatesAutoresizingMaskIntoConstraints = false
        self.twitBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -33).isActive = true
        self.twitBtn.centerYAnchor.constraint(equalTo: self.socNetLbl.centerYAnchor).isActive = true
        self.twitBtn.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.twitBtn.widthAnchor.constraint(equalTo: self.twitBtn.heightAnchor).isActive = true
        
        let twitImage = UIImage(named: "Registration/twit")?.withRenderingMode(.alwaysTemplate)
        self.twitBtn.setImage(twitImage, for: .normal)
        self.twitBtn.tintColor = .white
        
        self.view.addSubview(self.instBtn)
        self.instBtn.translatesAutoresizingMaskIntoConstraints = false
        self.instBtn.rightAnchor.constraint(equalTo: self.twitBtn.leftAnchor, constant: -22).isActive = true
        self.instBtn.centerYAnchor.constraint(equalTo: self.socNetLbl.centerYAnchor).isActive = true
        self.instBtn.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.instBtn.widthAnchor.constraint(equalTo: self.instBtn.heightAnchor).isActive = true
        
        let instImage = UIImage(named: "Registration/inst")?.withRenderingMode(.alwaysTemplate)
        self.instBtn.setImage(instImage, for: .normal)
        self.instBtn.tintColor = .white
        
        self.view.addSubview(self.faceBtn)
        self.faceBtn.translatesAutoresizingMaskIntoConstraints = false
        self.faceBtn.rightAnchor.constraint(equalTo: self.instBtn.leftAnchor, constant: -22).isActive = true
        self.faceBtn.centerYAnchor.constraint(equalTo: self.socNetLbl.centerYAnchor).isActive = true
        self.faceBtn.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.faceBtn.widthAnchor.constraint(equalTo: self.faceBtn.heightAnchor).isActive = true
        
        let faceImage = UIImage(named: "Registration/facebook")?.withRenderingMode(.alwaysTemplate)
        self.faceBtn.setImage(faceImage, for: .normal)
        self.faceBtn.tintColor = .white
        
        //------------------
        
        self.view.addSubview(self.nextVcBtn)
        self.nextVcBtn.translatesAutoresizingMaskIntoConstraints = false
        self.nextVcBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -33).isActive = true
        self.nextVcBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:  33).isActive = true
        self.nextVcBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.nextVcBtn.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        self.nextVcBtn.backgroundColor = UIColor(red: 0.131, green: 0.309, blue: 0.939, alpha: 1)
        self.nextVcBtn.layer.cornerRadius = 6
        
        self.nextVcBtn.setTitle("Next", for: .normal)
        self.nextVcBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        self.nextVcBtn.addTarget(self, action: #selector(self.nextVC), for: .touchUpInside)
        
        self.view.layoutIfNeeded()
        self.avatarBtn.layer.cornerRadius = self.avatarBtn.frame.height / 2
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        self.view.addGestureRecognizer(tapRecognizer)
        
    }
    
    @objc func nextVC(){
        //какая-то првоерка
        self.presenter.router.openNextStep()
        self.presenter.interactor.saveUserData()
    }

    @objc func hideKeyboard(){
        self.nameField.resignFirstResponder()
        self.cityFiled.resignFirstResponder()
        self.ageField.resignFirstResponder()
    }

    func textFiledSetUp(field: UserField, with top: NSLayoutYAxisAnchor,constant: CGFloat = 15, and type: TextFiledType){
        self.view.addSubview(field)

        field.translatesAutoresizingMaskIntoConstraints = false
        field.topAnchor.constraint(equalTo: top, constant: constant).isActive = true
        field.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -33).isActive = true
        field.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 33).isActive = true
        field.heightAnchor.constraint(equalToConstant: 65).isActive = true

        field.configure(type: .name)
    }
}

extension UserInfoRegistrationVC{
    class SocialNetWorkView: UIView{
        //потом напиать нормально
    }
}

extension UserInfoRegistrationVC{
    class UserField: UITextField{
        func configure(type: TextFiledType){
            let attributes: [NSAttributedString.Key : Any] = [.font : UIFont.systemFont(ofSize: 18), .foregroundColor : UIColor(red: 0.314, green: 0.314, blue: 0.314, alpha: 1)]
            let attributedString = NSAttributedString(string: type.rawValue, attributes: attributes)
            self.attributedPlaceholder = attributedString

            self.keyboardType = type.keyboardType

            self.layer.borderColor = UIColor(red: 0.314, green: 0.314, blue: 0.314, alpha: 1).cgColor
            self.layer.borderWidth = 1
            self.layer.cornerRadius = 4

            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: self.frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
    }

    enum TextFiledType: String{
        case name = "Твое имя"
        case city = "Твой город"
        case age = "Твой возраст"

        var keyboardType: UIKeyboardType{
            switch self {
            case .name:
                return .namePhonePad
            case .city:
                return .asciiCapable
            case .age:
                return .numberPad
            }
        }
    }
}

