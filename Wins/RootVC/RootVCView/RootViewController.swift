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
    
    private var user: User!
    internal var tricks = [Trick]()
    internal var lastTenTricks = [Trick]()
    
    internal var headerView = HeaderView()
    internal var statBtn = UIButton()
    internal var gameBtn = UIButton()
    internal var tableView = UITableView(frame: .zero, style: .grouped)
    
    internal var selectedIndex = [IndexPath]()
    
    private var gameView = GameView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
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
        
        self.view.addSubview(self.headerView)
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.headerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -33).isActive = true
        self.headerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 33).isActive = true
        self.headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        
        self.headerView.settingsBtn.addTarget(self, action: #selector(self.goToSettings), for: .touchUpInside)
        
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.tableView.register(StatTableViewCell.self, forCellReuseIdentifier: "StatTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.view.layoutIfNeeded()
        
        
        self.tableView.separatorStyle = .none
        self.tableView.bounces = false
        self.tableView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
        
        self.tableView.showsVerticalScrollIndicator = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @objc func goToSettings(){
        self.output.goToSettings()
    }
    
    @objc func goToStatiscits(){
        StatisticViewController.show(parent: self)
    }
    
    @objc func goToGame(){
        self.gameView = GameView(tricks: self.tricks, frame: self.view.frame, output: self.output)//GameView(frame: self.view.frame)
        self.view.addSubview(gameView)
    }
    
}

extension RootViewController: RootViewInpit{
    func reloadData(with lastTenTrick: [Trick]) {
        self.lastTenTricks = lastTenTrick
        self.tableView.reloadData()
    }
    
    func configure(with model: User?, and lastTenTrick: [Trick]) {
        guard let model = model else {
            self.output.goToReg()
            return
        }
        self.user = model
        self.headerView.configure(with: model)
        self.tricks = Array(model.skateTrick)
        self.lastTenTricks = lastTenTrick
        self.tableView.reloadData()
    }
}


extension RootViewController{
    internal class HeaderView: UIView{
        
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