//
//  RootVCChalengeView.swift
//  Wins
//
//  Created by Мурат Камалов on 19.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import UIKit

extension RootViewController:  UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2//DataManager._shared.user?.chalenges.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChalendgeCell", for: indexPath) as? ChalendgeCell
        cell!.configure(with: (DataManager._shared.user?.chalenges[0])!)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !(DataManager._shared.user?.chalenges[indexPath.row].isChalenge ?? true) else { return }
        //открываем страицу с турнирами
    }
}

extension RootViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 280, height: 135)
    }
}

extension RootViewController{
    class ChalendgeCell: UICollectionViewCell{
        private var mainLabel = UILabel()
        private var backgoundImage = UIImageView()
        private var sponspor = UILabel()
        private var date = UILabel()
        
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.setUp()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setUp(){
            self.addSubview(self.backgoundImage)
            self.backgoundImage.translatesAutoresizingMaskIntoConstraints = false
            self.backgoundImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            self.backgoundImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            self.backgoundImage.topAnchor.constraint(equalTo: self.topAnchor).isActive  = true
            self.backgoundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            
            self.addSubview(self.mainLabel)
            self.mainLabel.translatesAutoresizingMaskIntoConstraints = false
            self.mainLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 33).isActive = true
            self.mainLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant:  -33).isActive = true
            self.mainLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 26).isActive = true
            self.mainLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -67).isActive = true
            
            self.mainLabel.textColor = .white
            self.mainLabel.font = UIFont.systemFont(ofSize: 20)
            self.mainLabel.lineBreakMode = .byWordWrapping
            self.mainLabel.numberOfLines = 2
            self.mainLabel.minimumScaleFactor = 0.5
            
            let sponsporLael = UILabel()
            self.addSubview(sponsporLael)
            sponsporLael.translatesAutoresizingMaskIntoConstraints = false
            sponsporLael.leftAnchor.constraint(equalTo: self.mainLabel.leftAnchor).isActive = true
            sponsporLael.topAnchor.constraint(equalTo: self.mainLabel.bottomAnchor, constant: 26).isActive = true
            
            sponsporLael.text = "Sponsor"
            sponsporLael.textColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
            sponsporLael.font = UIFont.systemFont(ofSize: 10)
            
            self.addSubview(self.sponspor)
            self.sponspor.translatesAutoresizingMaskIntoConstraints = false
            self.sponspor.leftAnchor.constraint(equalTo: sponsporLael.leftAnchor).isActive = true
            self.sponspor.topAnchor.constraint(equalTo: sponsporLael.bottomAnchor, constant: 5).isActive = true
            
            self.sponspor.textColor = .white
            self.sponspor.font = UIFont.systemFont(ofSize: 12)
            
            
            self.addSubview(self.date)
            self.date.translatesAutoresizingMaskIntoConstraints = false
            self.date.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -33).isActive = true
            self.date.topAnchor.constraint(equalTo: self.sponspor.topAnchor).isActive = true
            
            self.date.textColor = .white
            self.date.font = UIFont.systemFont(ofSize: 12)
            
            let dateLabel = UILabel()
            self.addSubview(dateLabel)
            dateLabel.translatesAutoresizingMaskIntoConstraints = false
            dateLabel.topAnchor.constraint(equalTo: sponsporLael.topAnchor).isActive = true
            dateLabel.leftAnchor.constraint(equalTo: self.date.leftAnchor).isActive = true
            
            sponsporLael.text = "Date"
            sponsporLael.textColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
            sponsporLael.font = UIFont.systemFont(ofSize: 10)
        }
        
        func configure(with chalenge: Chalenges){
            if chalenge.isChalenge{
                self.mainLabel.text =  "Today's lucky trick - /n\(chalenge.trick!.name)"
            }else{
                self.mainLabel.text = "Turnament"
            }
            self.sponspor.text = chalenge.boardShop
            self.date.text = "30.04.2019"
        
            if let imageData = chalenge.sponsorImageData, let image = UIImage(data: imageData){
                self.backgoundImage.image = image
            }else{
                self.backgoundImage.image = UIImage(named: "Registration/Sports/Skate")
            }
        }
    }
}


