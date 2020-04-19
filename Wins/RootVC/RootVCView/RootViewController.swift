//
//  RootViewController.swift
//  Wins
//
//  Created by Мурат Камалов on 11.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import UIKit

class RootViewController: UIViewController{
    
    static var _shared: RootViewController = RootViewController()
    
    internal var output: RootViewOutput!
    
    private var headerView = HeaderView()
    private var statBtn = UIButton()
    private var gameBtn = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        //        let isGuest = true
        //        if isGuest{
        //            SportsRegVC.show(parent: self) {
        //                self.dismiss(animated: true, completion: nil)
        //            }
        ////            UserInfoRegistrationVC.show(parent: self)
        //        }
        
    }
    
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RootViewController{
    func setUp(){
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor =  UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
        
        let scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.addSubview(self.headerView)
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.headerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -33).isActive = true
        self.headerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 33).isActive = true
        self.headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        
        self.headerView.settingsBtn.addTarget(self, action: #selector(self.goToSettings), for: .touchUpInside)
    
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let chalengeView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        scrollView.addSubview(chalengeView)
        chalengeView.translatesAutoresizingMaskIntoConstraints = false
        chalengeView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        chalengeView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        chalengeView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor).isActive = true
        chalengeView.heightAnchor.constraint(equalToConstant: 135).isActive = true
        
        chalengeView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
        chalengeView.showsHorizontalScrollIndicator = false
        chalengeView.showsVerticalScrollIndicator = false
        chalengeView.contentInset = UIEdgeInsets(top: 0, left: 33, bottom: 0, right: 33)
        
        chalengeView.delegate = self
        chalengeView.dataSource = self
        
        chalengeView.register(ChalendgeCell.self, forCellWithReuseIdentifier: "ChalendgeCell")

        scrollView.addSubview(self.statBtn)
        self.statBtn.translatesAutoresizingMaskIntoConstraints = false
        self.statBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.statBtn.rightAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.statBtn.topAnchor.constraint(equalTo: chalengeView.bottomAnchor, constant: 42).isActive = true
        self.statBtn.heightAnchor.constraint(equalToConstant: 112).isActive = true
        
        self.statBtn.setTitle("Statistics", for: .normal)
        self.statBtn.setTitleColor(.white, for: .normal)
        self.statBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.statBtn.setImage(UIImage(named:"Registration/Sports/Skate"), for: .normal)
        
        self.statBtn.addTarget(self, action: #selector(self.goToStatiscits), for: .touchUpInside)
        
        scrollView.addSubview(self.gameBtn)
        self.gameBtn.translatesAutoresizingMaskIntoConstraints = false
        self.gameBtn.topAnchor.constraint(equalTo: self.statBtn.topAnchor).isActive = true
        self.gameBtn.bottomAnchor.constraint(equalTo: self.statBtn.bottomAnchor).isActive = true
        self.gameBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.gameBtn.leftAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.gameBtn.setTitle("Game", for: .normal)
        self.gameBtn.setTitleColor(.white, for: .normal)
        self.gameBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.gameBtn.setImage(UIImage(named:"Registration/Sports/Skate"), for: .normal)
    
        self.gameBtn.addTarget(self, action: #selector(self.goToGame), for: .touchUpInside)
    }
    
    @objc func goToSettings(){
        self.output.goToSettings()
    }
    
    @objc func goToStatiscits(){
        
    }
    
    @objc func goToGame(){
        
    }
    
}

extension RootViewController: RootViewInpit{
    func configure(with model: User?) {
        guard let model = model else {
            self.output.goToReg()
            return
        }
        self.headerView.configure(with: model)
    }
}


extension RootViewController{
    fileprivate class HeaderView: UIView{
        
        private let avatar = UIButton()
        private let nameLabel = UILabel()
        private let technicalLabel = UILabel()
        
        fileprivate let settingsBtn = UIButton()
        
        fileprivate init() {
            super.init(frame: .zero)
            self.setUp()
        }
        
        fileprivate func setUp(){
            self.heightAnchor.constraint(equalToConstant: 90).isActive = true
            
            self.addSubview(self.avatar)
            self.avatar.translatesAutoresizingMaskIntoConstraints = false
            self.avatar.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            self.avatar.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            self.avatar.heightAnchor.constraint(equalToConstant: 46).isActive = true
            self.avatar.widthAnchor.constraint(equalTo: self.avatar.heightAnchor).isActive = true
            
            self.avatar.setImage(UIImage(named: "Registration/avatar"), for: .normal)
            self.avatar.layer.borderWidth  = 1
            self.avatar.contentEdgeInsets =  UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8 )
            self.avatar.layer.borderColor = UIColor(red: 0.314, green: 0.314, blue: 0.314, alpha: 1).cgColor
            
            self.avatar.layer.cornerRadius = 46/2
            
            self.addSubview(self.nameLabel)
            self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
            self.nameLabel.leftAnchor.constraint(equalTo: self.avatar.rightAnchor, constant: 20).isActive = true
            self.nameLabel.topAnchor.constraint(equalTo: self.avatar.topAnchor, constant: 0).isActive = true
            
            self.nameLabel.textColor = .white
            self.nameLabel.font = UIFont.systemFont(ofSize: 18)
            
            self.addSubview(self.technicalLabel)
            self.technicalLabel.translatesAutoresizingMaskIntoConstraints = false
            self.technicalLabel.leftAnchor.constraint(equalTo: self.nameLabel.leftAnchor).isActive = true
            self.technicalLabel.bottomAnchor.constraint(equalTo: self.avatar.bottomAnchor, constant: 0).isActive = true
            
            self.technicalLabel.textColor = .white
            self.technicalLabel.font = UIFont.systemFont(ofSize: 12)
            
            self.addSubview(self.settingsBtn)
            self.settingsBtn.translatesAutoresizingMaskIntoConstraints = false
            self.settingsBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            self.settingsBtn.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            self.settingsBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
            self.settingsBtn.widthAnchor.constraint(equalTo: self.settingsBtn.heightAnchor).isActive = true
            
            let image = UIImage(named: "Menu/settingsIcon")?.withRenderingMode(.alwaysTemplate)
            self.settingsBtn.setImage(image, for: .normal)
            self.settingsBtn.tintColor = .white
            
            
        }
        
        fileprivate func configure(with user: User){
            self.nameLabel.text = user.login ?? "Guest"
            self.technicalLabel.text = "Technical skill: \(user.totalStats?.technicality ?? 0)"
            
            guard let imageData = user.avatarImageData,
                let image = UIImage(data: imageData) else { return }
            
            self.avatar.setImage(image, for: [])
            
        }
        
        private override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
