//
//  TrickModel.swift
//  Wins
//
//  Created by Мурат Камалов on 11.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//
import Foundation

struct Trick {
    var name: String
    var difficults: Float
    var stabuluty: Int
    var tries: Int
}

enum Tricks: Int, CaseIterable{
    case Ollie = 0
    case Switch_Ollie
    case KickFlip
    case Fakie_Ollie
    case Fake_KickFlip
    case Nolie
    
    var trick: Trick{
        switch self {
        case .Ollie:
            return Trick(name: "Ollie", difficults: 0, stabuluty: 0, tries: 0)
        case .Switch_Ollie:
            return Trick(name: "Swith Olie", difficults: 0, stabuluty: 0, tries: 0)
        case .Fakie_Ollie:
            return Trick(name: "Fakie Olie", difficults: 0, stabuluty: 0, tries: 0)
        case .Nolie:
            return Trick(name: "Nolie", difficults: 0, stabuluty: 0, tries: 0)
        case .KickFlip:
            return Trick(name: "Kick Flip", difficults: 0, stabuluty: 0, tries: 0)
        case .Fake_KickFlip:
            return Trick(name: "Fake Kickflip", difficults: 0, stabuluty: 0, tries: 0)
        }
    }
}

