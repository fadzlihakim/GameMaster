//
//  UserViewModel.swift
//  QuizMaster
//
//  Created by Fadzli on 15/03/2024.
//

import SwiftUI

class UserViewModel: ObservableObject{
    @Published var user: [User] = []
    @Published var name = ""
    @Published var score = 0
    
    func addUser(user:User){
        
    }
    
    func addScore(user:User){
//        user.score += 1
    }
}

let userData = [
    User(name: "", score: 0)
]
