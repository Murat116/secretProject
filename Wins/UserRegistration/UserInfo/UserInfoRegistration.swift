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

    //----------------------------------------------------------------------

    var avatarIV = UIImageView()
    var avatarBtn = UIButton()
    var addAvatarBtn = UIButton()
    
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

        //переписать на что - то более гибкое
        self.textFiledSetUp(field: self.nameField, with: self.bottomAnchorTitle!,constant: 30, and: .name)
        self.textFiledSetUp(field: self.cityFiled, with: self.nameField.bottomAnchor, and: .city)
        self.textFiledSetUp(field: self.ageField, with: self.cityFiled.bottomAnchor, and: .age)

        self.view.addSubview(self.avatarBtn)
        self.avatarBtn.translatesAutoresizingMaskIntoConstraints = false
        self.avatarBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 33).isActive = true
        self.avatarBtn.topAnchor.constraint(equalTo: self.ageField.bottomAnchor, constant: 26).isActive = true
        self.avatarBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.avatarBtn.widthAnchor.constraint(equalTo: self.avatarBtn.widthAnchor).isActive = true

        self.avatarBtn.layer.borderWidth = 1
        self.avatarBtn.layer.borderColor = UIColor(red: 0.314, green: 0.314, blue: 0.314, alpha: 1).cgColor

        self.view.addSubview(self.avatarIV)

        self.avatarIV.translatesAutoresizingMaskIntoConstraints = false
        self.avatarIV.centerYAnchor.constraint(equalTo: self.avatarBtn.centerYAnchor).isActive = true
        self.avatarIV.centerXAnchor.constraint(equalTo: self.avatarBtn.centerXAnchor).isActive = true
        self.avatarIV.heightAnchor.constraint(equalTo: self.avatarBtn.heightAnchor, constant: -8).isActive = true
        self.avatarIV.widthAnchor.constraint(equalTo: self.avatarIV.heightAnchor).isActive = true

        self.avatarIV.image = UIImage(named: "Registration/avatar")?.withRenderingMode(.alwaysTemplate)
        self.avatarIV.tintColor = UIColor(red: 0.314, green: 0.314, blue: 0.314, alpha: 1.0)

        self.view.layoutIfNeeded()
        self.avatarBtn.layer.cornerRadius = self.avatarBtn.frame.height
        
        self.view.addSubview(self.nextVcBtn)
        self.nextVcBtn.addTarget(self, action: #selector(self.nextVC), for: .touchUpInside)
    }
    
    @objc func nextVC(){
        //какая-то првоерка
        self.presenter.router.openNextStep()
        self.presenter.interactor.saveUserData()
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

extension UserInfoRegistrationVC: UserInfoRegViewProtocol{
    func setUp(with step: Int) {
        self.stepsType = .userInfo
        self.configure(step: self.stepsType)
    }
}
