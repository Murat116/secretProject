//
//  GameViewInteractor.swift
//  Wins
//
//  Created by Мурат Камалов on 04.05.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

class GameViewInteractor{
    weak var output: GameViewInteractorOutput!
    
    var skateTricks = [Trick]()
    var lastTenTrick = [Trick]()
    
    func startConfigure(){
        let actulChallenge = DataManager._shared.actualChallenges
        self.skateTricks = DataManager._shared.skateTricks
        self.lastTenTrick = self.getLastTenTricks()
        for trick in self.skateTricks{
            guard !self.lastTenTrick.filter({$0.name == trick.name}).isEmpty else { continue }
            let i = self.skateTricks.firstIndex(of: trick)
            self.skateTricks.remove(at: i!)
        }
        let tenTrick = self.generateTenTricks()
        self.output.configure(with: tenTrick, actulChallenge)
    }
    
    static func rundomTrick(tricks: [Trick], maxNumber:Int = 10) -> [Trick]{
        var tri = tricks
        if tri.isEmpty{
            tri = DataManager._shared.createSkateTricks() //FIXME: узнать почему он пустой и поправить
        }
        var tricksForGame = [Trick]()
        for _ in 1...maxNumber{
            let i = Int.random(in: 0..<tri.count)
            let trick = tri[i]
            tri.remove(at: i)
            tricksForGame.append(trick)
        }
        return tricksForGame
    }
    
    func getLastTenTricks() -> [Trick] {
        guard let user = DataManager._shared.user else { return [] }
        var lastTenTrick = DataManager._shared.lastTenTrick
        if lastTenTrick.isEmpty{
            let tricks = user.skateTrick
            lastTenTrick = GameViewInteractor.rundomTrick(tricks: Array(tricks))
            var lastTenTrickID = [String]()
            lastTenTrick.forEach { (trick) in
                lastTenTrickID.append(trick.name)
            }
            UserDefaults.standard.set(lastTenTrickID, forKey: USRDefKeys.lastTenTrick)
        }
        return lastTenTrick
    }
    
    func generateTenTricks() -> [Trick]{
        var arr = [Trick]()
        arr.append(self.generateTricks(maxStab: 10, minStab: 7, maxDif: 0.3))   //1
        arr.append(self.generateTricks(maxStab: 7, minStab: 5, maxDif: 0.4))    //2
        arr.append(self.generateTricks(maxStab: 5, minStab: 4, maxDif: 0.6))    //3
        arr.append(self.generateTricks(maxStab: 4, minStab: 3, maxDif: 0.7))    //4
        arr.append(self.generateTricks(maxStab: 3, minStab: 2, maxDif: 0.8))    //5
        arr.append(self.generateTricks(maxStab: 2, minStab: 1, maxDif: 0.9))    //6
        arr.append(self.generateTricks(maxStab: 0, minStab: 0, maxDif: 0.5))    //7
        arr.append(self.generateTricks(maxStab: 0, minStab: 0, maxDif: 0.8))    //8
        arr.append(self.rundomTrick())    //9
        arr.append(self.generateTricks(maxStab: 0, minStab: 0, maxDif: 1.0))   //10
        return arr
    }
    
    func generateTricks(maxStab: Int, minStab: Int, maxDif: Float) -> Trick {
        //выбираем трюк по стабильости
        let stabTricks = self.skateTricks.filter{$0.stability >= minStab && $0.stability <= maxStab}
        guard stabTricks.isEmpty else { return self.defaultTrick(with: maxDif) }
        //если трюки по стаибльности найдены, то выбираем трюк с максимальной сложностью
        let trickDif = self.maxDifTrick(tricks: stabTricks)
        
        guard trickDif != nil else { return self.defaultTrick(with: maxDif) }
        
        let index = self.skateTricks.firstIndex(of: trickDif!)!
        self.skateTricks.remove(at: index)
        
        return trickDif!
    }
    
    func defaultTrick(with dif: Float) -> Trick{
        //если такого трюка нет то выбираем трюк  с сложность по близкий к опреде сложности
        let trick = self.trickByDif(dif: dif)
        if trick == nil{
            //если и такого трюка нет, то на рандом
            return self.rundomTrick()
        }else{
            let index = self.skateTricks.firstIndex(of: trick!)!
            self.skateTricks.remove(at: index)
            return trick!
        }
    }
    
    //aлгоритм находящий трюк с максимальной сложности из имеющихся
    func maxDifTrick(tricks: [Trick]) -> Trick?{
        var maxDif: Float = 0
        var trickDif: Trick? = nil
        for trick in tricks{
            guard trick.complexity > maxDif else { continue}
            maxDif = trick.complexity
            trickDif = trick
        }
    
        return trickDif
    }
    
    //алгоритм находящий близки по сложности трюк из имеющихся
    func trickByCurrentDif(tricks: [Trick], dif: Float) -> Trick?{
        let maxDifTrick = self.maxDifTrick(tricks: tricks)
        guard let trickDif = maxDifTrick else { return nil}
        let maxDif = trickDif.complexity * dif
        var diferent: Float = 10
        var trickCurrentDif: Trick? = nil
        for trick in tricks{
            let difrnt = trick.complexity - maxDif
            if difrnt < diferent{
                diferent = difrnt
                trickCurrentDif = trick
            }
        }
        return trickCurrentDif
    }
    
    //трюк находящий трюк с близкой сложность
    func trickByDif(dif: Float) -> Trick?{
        let learnedTrick = self.skateTricks.filter{$0.stability >= 1}
        let difTrick = trickByCurrentDif(tricks: learnedTrick, dif: dif)
        if difTrick == nil{
            return self.maxDifTrick(tricks: learnedTrick)
        }else{
            return difTrick
        }
    }
    
    func rundomTrick() -> Trick{
        let index = Int.random(in: 0...(self.skateTricks.count - 1))
        let trick = self.skateTricks[index]
        self.skateTricks.remove(at: index)
        return trick
    }
}

extension GameViewInteractor: GameViewInteractorInput {
    func saveChanges(of trick: Trick, with dif: Float, and stab: Int) {
        DataManager._shared.lastTenTrick.removeFirst()
        DataManager._shared.lastTenTrick.append(trick)
        DataManager._shared.saveTrick(trick: trick, stab: stab, dif: dif)
    }
    
    func isChallengeDone(_ challenge: Challenge, done: Bool) {
        DataManager._shared.saveChallenge(challenge)
    }
    
    func recountTechnicalSkill() {
        let allTricks = DataManager._shared.skateTricks
        let doneTrick = allTricks.filter{$0.tries >= 1}
        var donesDif: Float = 0
        doneTrick.forEach{donesDif += $0.complexity}
        
        var allDif: Float = 0
        allTricks.forEach{allDif += $0.complexity}
        
        let techSkill = donesDif / allDif
        //FIXME: Умножать статистику на 10?
        DataManager._shared.saveTechnikalSkill(techSkill)
    }
}



//    1. Стабильность от 7 среди выполненных трюков с максимальной сложностью, если таких трюков нет, тогда выдавать трюк с 30% сложностью от максимального трюка который умеешь, если такого трюка нет, то любой трюк с сложностью не выше который умеешь
//    2. Стабильность от 5 среди выполненных трюков с максимальной сложностью, если таких трюков нет, тогда вызывать трюк с 40% сложность от максимального трюка который умеешь, то любой трюк с сложностью не выше который умеешь
//    3. Стабильность от 4 среди выполненных трюков с максимальной сложностью, если таких трюков нет, тогда вызывать трюк с 60% сложности от максимального трюка который умеешь, если нет, то любой трюк с сложностью не выше твоей
//    4. Стабильность от 3 среди выполненных трюков с максимальной сложностью, если таких трюков нет, тогда вызывать трюк с 70% сложности от максимального трюка который умеешь, если нет, то любой трюк с сложностью не выше твоей
//    5. Стабильность от 2 среди выполненных трюков с максимальной сложностью, если таких трюков нет, тогда вызывать трюк с 80% сложности от максимального трюка который умеешь, если нет, то любой трюк с сложностью не выше твоей
//    6. Стабильность от 1 среди выполненных трюков с максимальной сложностью, если таких трюков нет, тогда вызывать трюк с 90% сложности от максимального трюка который умеешь, если нет, то любой трюк с сложностью не выше твоей
//    7. Не умеешь трюк но сложность равна средней сложности от трюков которые умеешь, если таких трюков нет, то любой трюк который не умеешь с сложностью не больше сложности трюков которые умеешь
//    8. Не умеешь трюк но сложность равно 80% от максимальной сложности которую умеешь, если таких трюков нет, то любой трюк который не умеешь с сложность/ не большое сложности трюков которые умеешь
//    9. Любой трюк
//    10. Трюк который не умеешь и сложность трюка которого больше сложности трюка который умеешь
