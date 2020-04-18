//
//  TrickModel.swift
//  Wins
//
//  Created by Мурат Камалов on 11.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//
import Foundation
import RealmSwift



@objcMembers
class Trick: Object {
    dynamic var name: String = "Trick"
    dynamic var difficults: Float = 0.0 {
        didSet{
            self.difficults = self.difficults < 0 ? 0 : self.difficults
        }
    }
    dynamic var stabuluty: Int = 0 {
        didSet{
            self.stabuluty = self.stabuluty < 0 ? 0 : self.stabuluty
        }
    }
    dynamic var tries: Int = 0
    dynamic var id: Int = 0
}

enum SkateTricks: Int, CaseIterable{
    case Ollie = 0
    case Switch_Ollie
    case KickFlip
    case Fakie_Ollie
    case Fake_KickFlip
    case Nolie
    
    var parametrs: Trick{
        switch self {
        case .Ollie:
            return self.createTrick(name: "Ollie", difficults: 0, stabuluty: 0, tries: 0)
        case .Switch_Ollie:
            return createTrick(name: "Swith Olie", difficults: 0, stabuluty: 0, tries: 0)
        case .Fakie_Ollie:
            return createTrick(name: "Fakie Olie", difficults: 0, stabuluty: 0, tries: 0)
        case .Nolie:
            return createTrick(name: "Nolie", difficults: 0, stabuluty: 0, tries: 0)
        case .KickFlip:
            return createTrick(name: "Kick Flip", difficults: 0, stabuluty: 0, tries: 0)
        case .Fake_KickFlip:
            return createTrick(name: "Fake Kickflip", difficults: 0, stabuluty: 0, tries: 0)
        }
    }
    
    static var defaultSkateTrick: [Trick]{
        var trickArray = [Trick]()
        for trick in SkateTricks.allCases{
            trickArray.append(trick.parametrs)
        }
        return trickArray
    }
    
    func createTrick(name: String, difficults: Float, stabuluty: Int, tries: Int) -> Trick{
        let trick = Trick()
        trick.name = name
        trick.difficults = difficults
        trick.stabuluty = stabuluty
        trick.tries = tries
        return trick
    }
}

