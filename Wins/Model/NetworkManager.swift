//
//  NetworkManager.swift
//  Wins
//
//  Created by Роман Шуркин on 05.05.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    
    func getUser(id: String, completion: @escaping(User) -> Void)
    
    func saveUser(user: UserDTO)
    
    func checkOriginLogin(_ login: String, completion: @escaping(BoolRequest?) -> Void)
    
    func checkCorrectLoginAndPassword(_ login: String, _ password: String, completion: @escaping (BoolRequest?) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    
    let domen = "http://localhost"
    
    static var _shared = NetworkManager()
    
    func getUser(id: String, completion: @escaping(User) -> Void) {
        
        let urlString = domen + "/users/" + "\(id)"
        
        AF.request(urlString).responseDecodable(of: User.self) { response in
            
            var user: User?
            
            switch response.result {
            case .success(_):
                user = response.value
                completion(user!)
            case .failure(_):
                print("User is nil")
            }
        }
    }
    
    func saveUser(user: UserDTO) {
        
        let urlString = domen + "/users"
        
        var user = user
        
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
}
