//
//  User.swift
//  QuizMaster
//
//  Created by Fadzli on 15/03/2024.
//

import SwiftUI

struct User: Identifiable {
    var id = UUID()
    var name:String
    var score:Int
}
