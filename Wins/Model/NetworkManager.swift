//
//  NetworkManager.swift
//  Wins
//
//  Created by Роман Шуркин on 05.05.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

protocol NetworkManagerProtocol {
    
    func getUser(id: String, completion: @escaping(User?, AFError?) -> Void)
    
    func saveUser(user: User)
    
    func checkOriginLogin(_ login: String, completion: @escaping(BoolRequest?) -> Void)
    
    func checkCorrectLoginAndPassword(_ login: String, _ password: String, completion: @escaping (BoolRequest?) -> Void)
    
    func getActualChallenges(_ idOfUser: String, completion: @escaping([Challenge]?) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    let domen = "http://winsbackend.us-east-2.elasticbeanstalk.com"
//    let domen = "http://localhost"
    
    static var _shared = NetworkManager()
    
    func getUser(id: String, completion: @escaping(User?, AFError?) -> Void) {
        
        let urlString = domen + "/users/" + "\(id)"
        
        AF.request(urlString).responseDecodable(of: User.self) { response in
            
            completion(response.value, response.error)
        }
    }
    
    func saveUser(user: User) {
        
        guard var user = user.dto as? UserDTO else { return }
        
        let urlString = domen + "/users"
        
        user.challenges = [ChallengeDTO]()
        
        AF.request(urlString, method: .post, parameters: user, encoder: JSONParameterEncoder.default, headers: ["Content-Type" : "application/json"]).responseString { response in
            switch response.result {
            case .success(_):
                print("Success saving user")
            case .failure(_):
                print("error saving user")
            }
        }
    }
    
    func checkOriginLogin(_ login: String, completion: @escaping (BoolRequest?) -> Void) {
        
        let urlString = domen + "/users/check/login"
        
        AF.request(urlString, parameters: ["login" : login]).responseDecodable(of: BoolRequest.self) { response in
            
            switch response.result {
            case .success(_):
                completion(response.value)
            case .failure(_):
                print("failure of checking originality of user")
            }
        }
    }
    
    func checkCorrectLoginAndPassword(_ login: String, _ password: String, completion: @escaping (BoolRequest?) -> Void) {
        
        let urlString = domen + "/users/check/"
        
        AF.request(urlString, parameters: ["login" : login, "password" : password]).responseDecodable(of: BoolRequest.self) { response in
            
            switch response.result {
            case .success(_):
                completion(response.value)
            case .failure(_):
                print("failure of checking originality of user")
            }
        }
    }
    
    func getActualChallenges(_ idOfUser: String, completion: @escaping ([Challenge]?) -> Void) {
        
        let urlString = domen + "/users/challenges"
        
        AF.request(urlString, parameters: ["user_id" : idOfUser]).responseDecodable(of: [Challenge].self) { response in
            
            var challenges: [Challenge]?
            
            switch response.result {
            case .success(_):
                challenges = response.value
                completion(challenges)
            case .failure(_):
                print("Challenges is nil")
                completion(challenges)
            }
        }
    }
}
